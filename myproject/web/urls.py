from django.conf.urls import url
from web.views import index, cart, orders, users

urlpatterns = [
    url(r'^$', index.index, name='index'),                                    # 商城前台首页
    url(r'^list$', index.lists, name='list'),                                 # 商品列表
    url(r'^list/(?P<pIndex>[0-9]+)$', index.lists, name='list'),              # 商品列表
    url(r'^detail/(?P<gid>[0-9]+)$', index.detail, name='detail'),            # 商品详情

    # 会员登陆，退出
    url(r'^login$', index.login, name='login'),
    url(r'^dologin$', index.dologin, name='dologin'),
    url(r'^logout$', index.logout, name='logout'),
    url(r'^verify$', index.verify, name="verify"),                            # 验证码

    # 用户注册
    url(r'^register$', index.register, name='register'),
    url(r'^doreg$', index.doreg, name='doreg'),

    # 忘记密码
    url(r'^reset/$', users.reset, name='reset'),
    url(r'^update_pass/$', users.update_password, name='update_pass'),

    # 购物车路由
    url(r'^cart$', cart.index,name='cart_index'),                       # 浏览购物车
    url(r'^cart/add/(?P<gid>[0-9]+)$', cart.add,name='cart_add'),       # 添加购物车
    url(r'^cart/del/(?P<gid>[0-9]+)$', cart.delete,name='cart_del'),    # 从购物车中删除一个商品
    url(r'^cart/clear$', cart.clear,name='cart_clear'),                 # 清空购物车
    url(r'^cart/change$', cart.change,name='cart_change'),              # 更改购物车中商品数量

    # 订单管理
    url(r'^orders/add$', orders.add, name='orders_add'),                # 订单的表单页
    url(r'^orders/confirm$', orders.confirm, name='orders_confirm'),    # 订单确认页
    url(r'^orders/insert$', orders.insert, name='orders_insert'),       # 执行订单添加操作

    # 个人中心
    url(r'^vip/index$', users.index, name='vipuser'),
    url(r'^vip/update/(?P<uid>[0-9]+)$', users.update, name='vipupdate'),
    # 个人订单
    url(r'^vip/orders$', users.orders,name='viporders'),                # 会员中心我的订单
    url(r'^vip/odstate$', users.state,name='vipodstate'),               # 修改订单状态（确认收货

]
