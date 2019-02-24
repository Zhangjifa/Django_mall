from django.shortcuts import render, reverse, redirect
from django.http import HttpResponse
from django.core.paginator import Paginator
from django.db.models import Q
from common.models import Users
from datetime import datetime


def index(request, pIndex):
    ob = Users.objects
    # 定义一个存放搜索条件的列表
    mywhere = []
    keyword = request.GET.get("keyword", None)
    if keyword:
        list1 = ob.filter(Q(username__contains=keyword)|Q(name__contains=keyword))
        mywhere.append("keyword=" + keyword)
    else:
        list1 = ob.filter()

    sex = request.GET.get("sex", "")
    if sex != "":
        list1 = list1.filter(sex=int(sex))
        mywhere.append("sex=" + sex)
    # 执行分页处理
    pIndex = int(pIndex)
    page = Paginator(list1, 5)  # 以5条每页创建分页对象
    maxpages = page.num_pages  # 最大页数
    # 判断页数是否越界
    if pIndex > maxpages:
        pIndex = maxpages
    if pIndex < 1 or pIndex is None:
        pIndex = 1
    list2 = page.page(pIndex)  # 当前页数据
    plist = page.page_range  # 页码数列表
    context = {"userslist": list2, 'maxpages': maxpages, 'pIndex': pIndex, 'mywhere': mywhere, 'plist': plist}

    return render(request, 'myadmin/users/index.html', context)


def add(request):
    return render(request, 'myadmin/users/add.html')


def insert(request):
    try:
        ob = Users()
        ob.username = request.POST['username']
        ob.name = request.POST['name']
        # 获取密码并md5
        import hashlib
        m = hashlib.md5()
        m.update(bytes(request.POST['password'], encoding="utf8"))
        ob.password = m.hexdigest()
        ob.sex = request.POST['sex']
        ob.address = request.POST['address']
        ob.code = request.POST['code']
        ob.phone = request.POST['phone']
        ob.email = request.POST['email']
        ob.state = 1
        ob.addtime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        ob.save()
        context = {'info': '添加成功！'}
    except Exception as err:
        print(err)
        context = {'info': '添加失败！'}

    return render(request, "myadmin/info.html", context)


def delete(request, uid):
    try:
        ob = Users.objects.get(id=uid)
        ob.delete()
        context = {'info': '删除成功！'}
    except:
        context = {'info': '删除失败！'}

    return render(request, "myadmin/info.html", context)


def edit(request, uid):
    try:
        ob = Users.objects.get(id=uid)
        context = {'user': ob}
        return render(request, "myadmin/users/edit.html", context)
    except Exception as err:
        print(err)
        context = {'info': '没有找到要修改的信息！'}

    return render(request, "myadmin/info.html", context)


def update(request, uid):
    try:
        ob = Users.objects.get(id=uid)
        ob.name = request.POST['name']
        ob.sex = request.POST['sex']
        ob.address = request.POST['address']
        ob.code = request.POST['code']
        ob.phone = request.POST['phone']
        ob.email = request.POST['email']
        ob.state = request.POST['state']
        ob.save()
        context = {'info': '修改成功！'}
    except Exception as err:
        print(err)
        context = {'info': '修改失败！'}
    return render(request, "myadmin/info.html", context)


def update_passwd(request, uid):
    try:
        ob = Users.objects.get(id=uid)
        import hashlib
        m = hashlib.md5()
        m.update(bytes(request.POST['password'], encoding="utf8"))
        ob.password = m.hexdigest()
        ob.save()
        context = {'info': '重置密码成功！'}
    except Exception as err:
        print(err)
        context = {'info': '重置密码失败！'}
    return render(request, "myadmin/info.html", context)


def reset(request, uid):
    try:
        ob = Users.objects.get(id=uid)
        context = {'user': ob}
        return render(request, "myadmin/users/reset.html", context)
    except Exception as err:
        print(err)
        context = {'info': '没有找到要修改的信息！'}
        return render(request, "myadmin/info.html", context)


