import './click_widget.dart';
import './multi_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListHelperWidget extends StatefulWidget {

  /// item布局builder
  final OnItemWidgetBuild itemBuilder;

  /// 控制器，页面调用此组件方法所用
  final ListHelperControl controller;

  /// 是否启用下拉刷新，默认启用
  final bool enablePullDown;

  /// 是否启用加载更多，默认启用
  final bool enablePullUp;

  /// 是否自动首次加载，默认启用
  final bool initialRefresh;

  /// 是否需要返回头部按钮，默认启用
  final bool showTop;

  /// 需要页面实现的记载数据的回调
  final OnLoad onLoad;

  ListHelperWidget({
    Key key,
    @required this.controller,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.initialRefresh = true,
    this.showTop = true,
    @required this.itemBuilder,
    @required this.onLoad
  }) : super(key: key);

  ListHelperState createState() => ListHelperState(controller, initialRefresh, enablePullDown, enablePullUp, showTop);

}

class ListHelperState extends State<ListHelperWidget>{

  /// 正在加载中的页
  int loadingPage = 1;
  /// 当前页
  int page = 1;
  /// 总条数
  int totalCount = 0;
  /// 列表数据
  List<dynamic> listAll = [];

  bool initialRefresh;
  bool enablePullDown;
  bool enablePullUp;

  /// 是否需要回到头部按钮
  bool needShowTop = true;

  /// 是否展示回到头部
  bool isShowTop = false;

  RefreshController refreshController;
  MultiStateControl multiStateControl;
  ScrollController scrollController;

  ListHelperState(
      ListHelperControl controller,
      this.initialRefresh,
      this.enablePullDown,
      this.enablePullUp,
      this.needShowTop
      ){
    refreshController = RefreshController(initialRefresh: false);
    multiStateControl = MultiStateControl();
    scrollController = ScrollController();
    controller.loadStart = loadStart;
    controller.loadSuccess = loadSuccess;
    controller.loadFail = loadFail;
    controller.getItemData = getItemData;
    controller.getCurrentPage = getCurrentPage;
    controller.getLoadingPage = getLoadingPage;

    if(needShowTop){
      scrollController.addListener(() {
        bool tempShowTop = scrollController.offset > 1000;
        if(tempShowTop != isShowTop){
          setState(() {
            isShowTop = tempShowTop;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if(initialRefresh){
      loadStart(true);
    }
  }

  void onLoadMore(){
    loadingPage = page + 1;
    widget.onLoad(loadingPage);
  }

  int getCurrentPage(){
    return page;
  }

  int getLoadingPage(){
    return loadingPage;
  }

  void reset(){
    multiStateControl.changeLoading();
    listAll = [];
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  void loadStart(bool reset) {
    if(reset){
      listAll = [];
      multiStateControl.changeLoading();
      if(mounted){
        setState(() {});
      }
    }else{
      if(multiStateControl.getCurrentState() != -1 &&
          multiStateControl.getCurrentState() != MultiStateWidget.STATE_CONTENT &&
          multiStateControl.getCurrentState() != MultiStateWidget.STATE_LOADING){
        multiStateControl.changeLoading();
      }
    }
    refreshController.loadComplete();
    loadingPage = 1;
    widget.onLoad(loadingPage);
  }

  void loadSuccess(List list,int total) {
    totalCount = total;
    page = loadingPage;
    if(loadingPage == 1){
      listAll = [];
    }
    listAll.addAll(list);
    if(refreshController.isRefresh){
      refreshController.refreshCompleted();
    }
    if(refreshController.isLoading){
      if(listAll.length >= totalCount){
        refreshController.loadNoData();
      }else{
        refreshController.loadComplete();
      }
    }
    if(page == 1 && listAll.length == 0){
      multiStateControl.changeEmpty();
    }else{
      multiStateControl.changeContent();
    }
    setState(() {});
  }

  void loadFail(String msg) {
    loadingPage = page;
    if(refreshController.isRefresh){
      refreshController.refreshFailed();
    }
    if(refreshController.isLoading){
      refreshController.loadFailed();
    }
    setState(() {});
  }

  dynamic getItemData(int position) {
    return listAll[position];
  }

  @override
  Widget build(BuildContext context) {
    return MultiStateWidget(
      controller: multiStateControl,
      defaultState: initialRefresh ? MultiStateWidget.STATE_LOADING : MultiStateWidget.STATE_CONTENT,
      onRetry: () => loadStart(true),
      child: Stack(
        children: <Widget>[
          SmartRefresher(
            enablePullDown: enablePullDown,
            enablePullUp: enablePullUp,
            controller: refreshController,
            onRefresh: () => loadStart(false),
            onLoading: onLoadMore,
            child: ListView.builder(
              controller: scrollController,
              itemBuilder: (BuildContext context, int index){
                return widget.itemBuilder(context, index, listAll);
              },
              itemCount: listAll.length,
            ),
          ),
          isShowTop && needShowTop ? Positioned(
            right: 20,
            bottom: 30,
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.bottomRight,
              child: ClickWidget(
                backgroundColor: Colors.white,
                splashColor: Colors.blue,
                radius: 50,
                child: Image.asset("assets/main/images/list-helper-top.png"),
                onClick: ()=> scrollController.animateTo(0, duration: Duration(milliseconds: 250), curve: Curves.ease),
              ),
            ),
          ): Container(width: 0, height: 0,)
        ],
      ),
    );
  }

}

class ListHelperControl{

  /// 手动触发刷新
  void Function(bool reset) loadStart;

  /// 加载成功时调用
  void Function(List list, int total) loadSuccess;

  /// 加载失败时调用
  void Function(String msg) loadFail;

  /// 获取指定数据
  void Function(int position) getItemData;

  /// 获取当前页
  int Function() getCurrentPage;

  /// 获取正在加载中的页数
  int Function() getLoadingPage;
}

typedef Widget OnItemWidgetBuild(BuildContext context, int index, List<dynamic> list);
typedef void OnLoad(int page);