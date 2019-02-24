from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from common.models import Goods, Types, Orders, Detail, Goods
from datetime import datetime
from django.utils.timezone import utc


# 公共信息加载
def loadinfo(request):
    '''公共信息加载'''
    context = {}
    lists = Types.objects.filter(pid=0)
    context['typelist'] = lists
    return context


def add(request):
    '''浏览购物车'''
    context = loadinfo(request)
    ids = request.GET.get("ids", "")
    if len(ids) < 1:
        context = {"info":"请选择要结算的商品！"}
        return render(request, "web/ordersinfo.html", context)
    gidlist = ids.split(",")

    # 获取购物车列表中的商品信息
    shoplist = request.session['shoplist']
    orderslist = {}
    total = 0.0
    for gid in gidlist:
        orderslist[gid] = shoplist[gid]
        total += shoplist[gid]["price"] * shoplist[gid]["num"]
    # 将这些信息写道session中
    request.session["orderslist"] = orderslist
    request.session["total"] = total
    return render(request, "web/ordersadd.html")


def confirm(request):
    context = loadinfo(request)
    return render(request, "web/ordersconfirm.html", context)


def insert(request):
    context = loadinfo(request)
    try:
        # 执行订单信息添加操作
        od = Orders()
        od.uid = request.session['vipuser']['id'] #当前登录者的id号
        od.linkman = request.POST.get('linkman')
        od.address = request.POST.get('address')
        od.code = request.POST.get('code')
        od.phone = request.POST.get('phone')
        od.addtime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        od.total = request.session['total']
        od.state = 0
        od.save()

        # 执行订单详情添加
        orderslist = request.session['orderslist']
        shoplist = request.session['shoplist']
        for shop in orderslist.values():
            og = Goods.objects.get(id=shop["id"])           # 获取购买的商品对象
            del shoplist[str(shop['id'])]
            ov = Detail()
            ov.orderid = od.id
            ov.goodsid = shop['id']
            ov.name = shop['goods']
            ov.price = shop['price']
            ov.num = shop['num']
            og.num += int(shop["num"])                      # 商品销量实际累加
            og.save()
            ov.save()
        del request.session['orderslist']  
        del request.session['total']
        request.session['shoplist'] = shoplist
        context = {"info":"订单添加成功！订单号："+ str(od.id)}
        return render(request,"web/ordersinfo.html", context)
    except Exception as err:
        print(err)
        context = {"info":"订单添加失败，请稍后再试！"}
        return render(request,"web/ordersinfo.html", context)
