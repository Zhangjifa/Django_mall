from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from common.models import Users, Types, Orders, Detail, Goods
from datetime import datetime
from django.db.models import Q


# 公共信息加载
def loadinfo(request):
    '''公共信息加载'''
    context = {}
    lists = Types.objects.filter(pid=0)
    context['typelist'] = lists
    return context


def index(request):
    context = loadinfo(request)
    ob = Users.objects.get(id=request.session["vipuser"]["id"])
    context["userlist"] = ob
    return render(request, "web/vipuser.html", context)


def update(request, uid):
    try:
        context = loadinfo(request)
        ob = Users.objects.get(id=uid)
        ob.name = request.POST["name"]
        ob.sex = request.POST["sex"]
        ob.address = request.POST["address"]
        ob.email = request.POST["email"]
        ob.code = request.POST['code']
        ob.phone = request.POST['phone']
        ob.save()
        context = {"info": "修改个人信息成功 ！"}


    except Exception as err:
        print(err)
        context = {"info": "修改用户信息失败 ！"}

    return render(request, "web/vipuserinfo.html", context)


def orders(request):
    print(1111)
    context = loadinfo(request)
    # 获取当前用户的订单列表
    odlist = Orders.objects.filter(uid=request.session['vipuser']['id'])
    # 遍历当前用户的所有订单，添加他的订单详情
    for od in odlist:
        delist = Detail.objects.filter(orderid=od.id)
        # 遍历每个商品详情，从Goods中获取对应的图片
        for og in delist:
            og.picname = Goods.objects.only('picname').get(id=og.goodsid).picname
            print(og.picname)
        od.detaillist = delist
    # 将整理好的订单信息放置到模板遍历中
    context['orderslist'] = odlist
    return render(request,"web/viporders.html", context)


def state(request):
    ''' 修改订单状态 '''
    try:
        oid = request.GET.get("oid",'0')
        ob = Orders.objects.get(id=oid)
        ob.state = request.GET['state']
        ob.save()
        return redirect(reverse('viporders'))
    except Exception as err:
        print(err)
        return HttpResponse("订单处理失败！")


def reset(request):
    return render(request, "web/reset.html")


def update_password(request):
    try:
        ob = Users.objects.get(Q(username=request.POST["username"]) & Q(phone=request.POST["phone"]))

        import hashlib
        m = hashlib.md5()
        m.update(bytes(request.POST['password'], encoding="utf8"))
        ob.password = m.hexdigest()
        ob.save()
        context = {'info': '重置密码成功, 请登陆！'}

    except Exception as err:
        print(err)
        context = {"info": "未找到该用户，请核对后重新输入"}
    return render(request, "web/reset.html", context)
