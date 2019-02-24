from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.core.paginator import Paginator
from common.models import Goods, Types
from PIL import Image
import time, os


def index(request, pIndex):
    goods = Goods.objects.all()
    for ob in goods:
        ty = Types.objects.get(id=ob.typeid)
        ob.typename = ty.name

    # 执行分页处理
    pIndex = int(pIndex)
    page = Paginator(goods, 5)  # 以5条每页创建分页对象
    maxpages = page.num_pages  # 最大页数
    # 判断页数是否越界
    if pIndex > maxpages:
        pIndex = maxpages
    if pIndex < 1 or pIndex is None:
        pIndex = 1
    list2 = page.page(pIndex)  # 当前页数据
    plist = page.page_range  # 页码数列表
    context = {"goodslist": list2, 'maxpages': maxpages, 'pIndex': pIndex, "plist": plist}
    return render(request, "myadmin/goods/index.html", context)


def add(request):
    tlist = Types.objects.extra(select={'_has': 'concat(path,id)'}).order_by('_has')
    for ob in tlist:
        ob.pname ='. . .'*(ob.path.count(',')-1)

    context = {"typeslist": tlist}
    return render(request, "myadmin/goods/add.html", context)


def insert(request):
    try:
        upfile = request.FILES.get('picname', None)
        if not upfile:
            return HttpResponse("没有上传的文件")
        # 随机生成一个文件名
        filename = str(time.time()) + "." + upfile.name.split('.').pop()
        ob = open("./static/goods/" + filename, "wb+")
        for chunk in upfile.chunks():  # 分块写入文件
            ob.write(chunk)
        ob.close()

        im = Image.open("./static/goods/"+filename)
        # 缩放到375*375:
        im.thumbnail((375, 375))
        # 把缩放后的图像用jpeg格式保存:
        im.save("./static/goods/"+filename, 'jpeg')
        # 缩放到220*220:
        im.thumbnail((220, 220))
        # 把缩放后的图像用jpeg格式保存:
        im.save("./static/goods/m_"+filename, 'jpeg')
        # 缩放到75*75:
        im.thumbnail((75, 75))
        # 把缩放后的图像用jpeg格式保存:
        im.save("./static/goods/s_"+filename, 'jpeg')

        # 执行信息添加
        ob = Goods()
        ob.goods = request.POST['goods']
        ob.typeid = request.POST['typeid']
        ob.company = request.POST['company']
        ob.price = request.POST['price']
        ob.store = request.POST['store']
        ob.content = request.POST['content']
        ob.picname = filename
        ob.save()
        context = {'info': "添加商品信息成功"}
    except Exception as err:
        context = {'info': err}

    return render(request, "myadmin/info.html", context)


def delete(request, gid):
    try:
        goods = Goods.objects.get(id=gid)
        goods.delete()
        context = {"info": "删除商品成功"}
    except Exception as err:
        context = {"info": err}

    return render(request, "myadmin/info.html", context)


def edit(request, gid):
    try:
        tlist = Types.objects.extra(select={'_has': 'concat(path,id)'}).order_by('_has')
        for ob in tlist:
            ob.pname = '. . .' * (ob.path.count(',') - 1)

        goods = Goods.objects.get(id=gid)
        context = {"goodslist": goods, "typeslist": tlist}
        return render(request, "myadmin/goods/edit.html", context)
    except Exception as err:
        print(err)
        context = {"info": err}
        return render(request, "myadmin/info.html", context)


def update(request, gid):
    try:
        oldpicname = request.POST['oldpicname']
        flag = False
        if request.FILES.get('picname') is not None:
            upfile = request.FILES.get('picname', None)
            if not upfile:
                return HttpResponse("没有上传的文件")
            # 随机生成一个文件名
            filename = str(time.time()) + "." + upfile.name.split('.').pop()
            ob = open("./static/pics/" + filename, "wb+")
            for chunk in upfile.chunks():  # 分块写入文件
                ob.write(chunk)
            ob.close()

            # 执行图片缩放
            im = Image.open("./static/pics/" + filename)
            # 缩放到375*375:
            im.thumbnail((375, 375))
            # 把缩放后的图像用jpeg格式保存:
            im.save("./static/pics/" + filename, None)
            # 缩放到75*75:
            im.thumbnail((75, 75))
            # 把缩放后的图像用jpeg格式保存:
            im.save("./static/pics/s_" + filename, None)
            flag = True
        else:
            filename = oldpicname

        # 执行信息添加
        ob = Goods.objects.get(id=gid)
        ob.goods = request.POST['goods']
        ob.typeid = request.POST['typeid']
        ob.company = request.POST['company']
        ob.price = request.POST['price']
        ob.store = request.POST['store']
        ob.content = request.POST['content']
        ob.picname = filename
        ob.state = request.POST['state']
        ob.save()
        context = {'info': "修改商品信息成功"}
        if flag is True:
            os.remove("./static/goods/s_" + oldpicname)  # 执行老图片删除
            os.remove("./static/goods/" + oldpicname)  # 执行老图片删除

    except Exception as err:
        context = {'info': err}

    return render(request, "myadmin/info.html", context)
