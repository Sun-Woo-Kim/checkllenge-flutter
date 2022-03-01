// 03_챌린지 만들기

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';

import 'package:onlyone/views/03_challenge_creation/create_challenge_view_detail.dart';

import 'package:onlyone/models/book.dart';

class SearchBookView extends StatefulWidget {
  @override
  SearchBookViewState createState() => SearchBookViewState();
}

class SearchBookViewState extends State<SearchBookView> {
  TextEditingController searchController = TextEditingController();
  late List books;

  @override
  void initState() {
    super.initState();
    books = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: Colors.white,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        leading: Text(""),
        leadingWidth: 10,
        title: Text(
          "",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.clear, size: 30),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
        ]);
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text('어떤 책을 같이 읽을까요?',
                style: FontTheme.h3_with(ColorTheme.gray900)),
          ),
          SizedBox(height: 8),
          _searchField(),
          _searchedRow(), // textField 책이름을 검색해주세요.
        ],
      ),
    );
  }

  Timer? _debounce;
  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 150), () {
      searchBook(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Widget _searchField() {
    return Container(
      color: ColorTheme.gray200,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        style: FontTheme.p_with(ColorTheme.gray900),
        onSubmitted: (String value) {
          _onSearchChanged(value);
        },
        onChanged: (String value) {
          _onSearchChanged(value);
        },
        controller: searchController,
        decoration: InputDecoration(
          hintText: "책 이름을 검색해주세요",
          suffixIcon: IconButton(
            icon: Image.asset("images/ic_32_search.png", height: 32),
            onPressed: () {
              _onSearchChanged(searchController.text);
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  searchBook(value) async {
    var response = await NetworkManager().getBookList(value);
    if (response.didSucceed) {
      setState(() {
        if (response.data!.length > 0) {
          books = response.data!;
        }
      });
    }
  }

  Widget _searchedRow() {
    return Expanded(
        child: (books.length > 0)
            ? _buildListView()
            : Container(
                alignment: Alignment.center,
                child: Text("검색 결과가 없습니다",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18)),
              ));
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return CreateChallengeViewDetail(book: books[index]);
            }));
          },
          child: _BookRow(key: Key(books[index].isbn), book: books[index]),
        );
      },
    );
    // return AnimatedList(
    //     // animation 되도록 시도중... (실패)
    //     initialItemCount: books.length,
    //     itemBuilder: (context, index, animation) {
    //       return GestureDetector(
    //         onTap: () {
    //           Navigator.push(context, MaterialPageRoute(builder: (_) {
    //             return CreateChallengeViewDetail(book: books[index]);
    //           }));
    //         },
    //         child: _bookRow(key: Key(books[index].isbn), book: books[index]),
    //       );
    //     });
  }
}

class _BookRow extends StatelessWidget {
  final Book book;
  _BookRow({required Key key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 82,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Hero(
                tag: book.isbn,
                child: book.thumbnailImagePath.isEmpty
                    ? Image.asset('images/img_default.png',
                        width: 44, height: 68, fit: BoxFit.fill)
                    : Image.network(book.thumbnailImagePath,
                        width: 44, height: 68, fit: BoxFit.fill),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 116,
                alignment: Alignment.centerLeft,
                child: Text(
                  book.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: FontTheme.p_with(ColorTheme.gray900),
                ),
              ),
            ),
          ],
        ));
  }
}
