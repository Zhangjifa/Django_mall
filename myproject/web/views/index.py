from django.shortcuts import render, redirect, reverse
from django.http import HttpResponse
from datetime import datetime
from django.core.paginator import Paginator
from django.db.models import Q

from common.models import Users, Types, Goods;


# Create your views here.
def loadinfo(request):
    lists = Types.objects.filter(pid=0)
    context = {"typelist": lists}
    return context


# 商城前台首页
def index(request):
    context = loadinfo(request)
    og = Goods.objects.order_by("clicknum")[5]
    context["goodlist"] = og
    return render(request, "web/index.html", context)


# 商品列表页
def lists(request, pIndex=1):
    context = loadinfo(request)

    new = int(request.GET.get("new", 0))
    price = int(request.GET.get("price", 0))

    # try:
    #
    ob = Goods.objects
    mywhere = []

    tid = int(request.GET.get('tid', 0))

    if tid > 0:
        ob = ob.filter(typeid__in=Types.objects.only('id').filter(pid=tid))
        mywhere.append("tid=" + str(tid))
    else:
        ob = ob.filter()

    if new == 1:
        goods = ob.filter(state=1).order_by("-addtime")
        mywhere.append("new=" + str(new))
    elif price == 1:
        goods = ob.order_by("-price")
        mywhere.append("price=" + str(price))
    else:
        goods = ob.order_by("-clicknum")


    #执行分页处理
    pIndex = int(pIndex)
    page = Paginator(goods, 4) #以5条每页创建分页对象
    maxpages = page.num_pages #最大页数
    #判断页数是否越界
    if pIndex > maxpages:
        pIndex = maxpages
    if pIndex < 1:
        pIndex = 1
    list2 = page.page(pIndex) #当前页数据
    plist = page.page_range   #页码数列表
    # 封装信息加载模板输出
    context['goodslist'] = list2
    context['plist'] = plist
    context['pIndex'] = pIndex
    context['maxpages'] = maxpages
    context['mywhere'] = mywhere
    context['tid'] = int(tid)

    # print(maxpages, pIndex)

    return render(request, "web/list.html", context)


# 商品详情页
def detail(request, gid):
    context = loadinfo(request)
    ob = Goods.objects.get(id=gid)
    ob.clicknum += 1
    ob.save()
    context["good"] = ob
    return render(request, "web/detail.html", context)


def login(request):
    return render(request, "web/login.html")


def dologin(request):
    # 校验验证码
    verifycode = request.session['verifycode']
    code = request.POST['code']
    if verifycode != code:
        context = {'info': '验证码错误！'}
        return render(request, "web/login.html", context)

    try:
        # 根据账号获取登录者信息
        user = Users.objects.get(username=request.POST['username'])
        if user.state == 0 or user.state == 1:
            # 验证密码
            import hashlib
            m = hashlib.md5() 
            m.update(bytes(request.POST['password'], encoding="utf8"))
            if user.password == m.hexdigest():
                # 此处登录成功，将当前登录信息放入到session中，并跳转页面
                request.session['vipuser'] = user.toDict()
                return redirect(reverse('index'))
            else:
                context = {'info': '登录账号或密码错误!'}
        else:
            context = {'info': '此用户为非法用户！'}
    except Exception as err:
        print(err)
        context = {'info': '登录账号或密码错误！'}
    return render(request, "web/login.html", context)


def logout(request):
        # 清除登录的session信息
    del request.session['vipuser']
    # 跳转登录页面（url地址改变）
    return redirect(reverse('login'))


# 验证码
def verify(request):
    # 引入随机函数模块
    import random
    from PIL import Image, ImageDraw, ImageFont
    # 定义变量，用于画面的背景色、宽、高
    # bgcolor = (random.randrange(20, 100), random.randrange(
    #    20, 100),100)
    bgcolor = (242,164,247)
    width = 100
    height = 25
    # 创建画面对象
    im = Image.new('RGB', (width, height), bgcolor)
    # 创建画笔对象
    draw = ImageDraw.Draw(im)
    # 调用画笔的point()函数绘制噪点
    for i in range(0, 100):
        xy = (random.randrange(0, width), random.randrange(0, height))
        fill = (random.randrange(0, 255), 255, random.randrange(0, 255))
        draw.point(xy, fill=fill)
    # 定义验证码的备选值
    str1 = 'ABCD123EFGHIJK456LMNOPQRS789TUVWXYZ0'
    # 随机选取4个值作为验证码
    rand_str = ''
    for i in range(0, 4):
        rand_str += str1[random.randrange(0, len(str1))]
    # 构造字体对象
    font = ImageFont.truetype('static/arial.ttf', 21)
    # font = ImageFont.load_default().font
    # 构造字体颜色
    fontcolor = (255, random.randrange(0, 255), random.randrange(0, 255))
    # 绘制4个字
    draw.text((5, 2), rand_str[0], font=font, fill=fontcolor)
    draw.text((25, 2), rand_str[1], font=font, fill=fontcolor)
    draw.text((50, 2), rand_str[2], font=font, fill=fontcolor)
    draw.text((75, 2), rand_str[3], font=font, fill=fontcolor)
    # 释放画笔
    del draw
    # 存入session，用于做进一步验证
    request.session['verifycode'] = rand_str
    # 内存文件操作-->此方法为python3的
    import io
    buf = io.BytesIO()
    # 将图片保存在内存中，文件类型为png
    im.save(buf, 'png')
    # 将内存中的图片数据返回给客户端，MIME类型为图片png
    return HttpResponse(buf.getvalue(), 'image/png')


def register(request):
    return render(request, "web/register.html")


def doreg(request):
    try:
        ob = Users()
        ob.username = request.POST['username']
        # 获取密码并md5
        import hashlib
        m = hashlib.md5()
        m.update(bytes(request.POST['password'], encoding="utf8"))
        ob.password = m.hexdigest()
        ob.addtime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        ob.save()
        context = {'info': '注册成功, 请登陆！'}
    except Exception as err:
        print(err)
        context = {'info': '注册失败，请重试！'}

    return render(request, "web/register.html", context)
