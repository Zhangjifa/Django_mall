from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse

from common.models import Goods,Types

# 公共信息加载
def loadinfo(request):
    '''公共信息加载'''
    context = {}
    lists = Types.objects.filter(pid=0)
    context['typelist'] = lists
    return context

def index(request):
    '''浏览购物车'''
    context = loadinfo(request)
    if "shoplist" not in request.session:
        request.session["shoplist"] = {}
    return render(request, "web/cart.html", context)


def add(request,gid):
    '''在购物车中放入商品信息'''
    # 获取要放入购物车中的商品信息
    ob = Goods.objects.get(id=gid)
    shop = ob.toDic()
    shop["num"] = int(request.POST.get("num", 1))
    print(type(shop["num"]))
    # 获取购物车中已存在商品的列表
    shoplist = request.session.get("shoplist", {})
    # 判断当前购买的商品是否已存在于购物车中
    if gid in shoplist:
        shoplist[gid]["num"] += shop["num"]
    else:
        shoplist[gid] = shop
    # 将购物车列表写回到session
    request.session["shoplist"] = shoplist
    return redirect(reverse('cart_index'))


def delete(request,gid):
    '''删除一个商品'''
    context = loadinfo(request)
    shoplist =  request.session["shoplist"]
    del shoplist[gid]
    request.session["shoplist"] = shoplist
    return redirect(reverse('cart_index'))


def clear(request):
    '''清空购物车'''
    context = loadinfo(request)
    request.session["shoplist"] = {}
    return render(request,"web/cart.html",context)


def change(request):
    '''更改购物车中的商品信息'''
    shoplist = request.session['shoplist']
    #获取信息
    shopid = request.GET.get('gid','0')
    num = int(request.GET.get('num', 1))
    if num < 1:
        num = 1
    shoplist[shopid]['num'] = num #更改商品数量
    request.session['shoplist'] = shoplist
    return redirect(reverse('cart_index'))