import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:test_store/authentication/authentication.dart';
import 'package:test_store/home/widgets/widgets.dart';
import 'package:test_store/products/products.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        email: context.select((AuthenticationBloc bloc) => bloc.state.user.id),
        onLogout: () {
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationLogoutRequested());
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Align(
                    child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      color: Color.fromRGBO(0, 0, 0, 1),
                      iconSize: 32,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    child: Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.078),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const TextField(
                        cursorColor: Color.fromARGB(255, 31, 108, 114),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Color(0xff8f8f91),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 12.0,
                top: 16,
              ),
              child: Text(
                'Special offers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 8),
              child: const Text(
                'The best prices',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    color: Colors.grey.shade800,
                    onRefresh: () async =>
                        context.read<ProductsCubit>().refreshProducts(),
                    child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(3, 23),
                                spreadRadius: -13,
                                blurRadius: 40,
                                color: Color.fromRGBO(0, 0, 0, 0.17),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        state.products[index].image),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      state.products[index].title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.visible,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: <Widget>[
                                        buildStarRating(
                                          state.products[index].rating.rate,
                                        ),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          '\$ ${state.products[index].price}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            right: 10,
                                            bottom: 10,
                                          ),
                                          child:
                                              const Icon(Icons.favorite_border),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 31, 108, 114),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        onPressed: () {},
        child: const SizedBox(
          width: 50,
          height: 50,
          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildStarRating(double rating) {
    final stars = <Widget>[];
    for (var i = 1; i <= 5; i++) {
      if (i <= rating) {
        // Full Star
        stars.add(
          const Padding(
            padding: EdgeInsets.only(left: 3),
            child: Icon(
              Icons.brightness_1_rounded,
              color: Color.fromARGB(255, 255, 217, 0),
              size: 10,
            ),
          ),
        );
      } else if (i - rating < 1) {
        // Half Star
        stars.add(
          const Padding(
            padding: EdgeInsets.only(left: 3),
            child: Icon(
              Icons.brightness_1_rounded,
              color: Color.fromARGB(255, 255, 217, 0),
              size: 10,
            ),
          ),
        );
      } else {
        // Empty Star
        stars.add(
          const Padding(
            padding: EdgeInsets.only(left: 3),
            child: Icon(
              Icons.brightness_1_rounded,
              color: Color.fromARGB(255, 201, 200, 200),
              size: 10,
            ),
          ),
        );
      }
    }
    return Row(children: stars);
  }
}
