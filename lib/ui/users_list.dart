import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/user_bloc.dart';
import 'package:random_user/bloc/user_event.dart';
import 'package:random_user/bloc/user_state.dart';
import 'package:random_user/widgets/bottom_loader.dart';
import 'package:random_user/widgets/user_page_item.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final _scrollController = ScrollController();
  PageController _pageController;
  final UserBloc _userBloc = UserBloc();
  int _pageViewIndex;
  bool _isTapped;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _userBloc.add(UserFetched());
     _pageViewIndex = 0;
     _isTapped = false;
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: _pageViewIndex, keepPage: false);
    _pageController.addListener(_onPageViewScroll);
    return BlocBuilder(
      bloc: _userBloc,
      builder: (BuildContext context, UserState state) {
        switch (state.status) {
          case UserStatus.failure:
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Произошла ошибка"),
                    FlatButton(
                      onPressed: () {
                        _userBloc.add(UserFetched());
                        },
                      child: Text("Повторить",
                      style: TextStyle(
                        color: Colors.blue
                      ),
                      ),
                    )
                  ],
                ),
              ),
            );
          case UserStatus.success:
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(title: Text('Random Users')),
                  body: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.users.length
                          ? BottomLoader()
                          : Container(
                             color: _isTapped ? Colors.black.withOpacity(0.9):Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                              backgroundImage:
                               NetworkImage(state.users[index].pictureSmall),
                              ),
                             title: Text(
                               state.users[index].fullName(),
                                style: TextStyle(
                              fontWeight: FontWeight.bold,
                                 ),
                              ),
                               subtitle: Text(state.users[index].address()),
                               onTap: () {
                            _pageViewIndex = index;
                            _isTapped = true;
                            setState(() {});
                        },
                      ),
                          );
                    },
                    itemCount: state.users.length + 1,
                    controller: _scrollController,
                  ),
                  ),
                  Visibility(
                   visible: _isTapped,
                    child: PageView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(
                              title: Text((index + 1).toString()+" из "+ state.users.length.toString()),
                                centerTitle: true,
                                actions: <Widget>[
                                    IconButton(
                                       icon: Icon(Icons.clear),
                                      onPressed: (){
                                        _isTapped = false;
                                           setState(() {});
                                      }
                                    ),
                                 ]
                            ),
                            body: index >= state.users.length? Center(child: CircularProgressIndicator())
                                :UserPageItem(users: state.users,index: index)
                        );
                      },
                      itemCount: state.users.length + 1,
                      controller: _pageController,
                      onPageChanged: (int index) {
                        setState(() {
                          _pageViewIndex = index;
                        });
                      }
                    )
                  )
              ],
            );
          default:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _userBloc.add(UserFetched());
    }
  }

  void _onPageViewScroll() {
    if ( _isNeedAddPageView) {
      _pageController.removeListener(_onPageViewScroll);
      Future.delayed(Duration(seconds: 1), () {
        _userBloc.add(UserFetched());
        _pageController.addListener(_onPageViewScroll);
      });
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.999);
  }

  bool get _isNeedAddPageView {
    return _pageViewIndex + 1 > _userBloc.state.users.length;
  }
}

