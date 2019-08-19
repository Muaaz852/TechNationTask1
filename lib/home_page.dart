import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:tech_nation_task_1/api/api.dart';

import 'package:tech_nation_task_1/models/banners.dart' as my;
import 'package:tech_nation_task_1/models/banner.dart' as my;

import 'models/event.dart';
import 'models/user.dart';

class HomePage extends StatelessWidget {
  final ApiClient _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(screenSize),
            const SizedBox(height: 30.0),
            const Padding(
              padding: const EdgeInsets.only(left: 30.0, bottom: 14.0),
              child: const Text(
                "All Events",
                style: const TextStyle(color: Colors.grey, fontSize: 17.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: _buildEventsList(screenSize),
            ),
            const SizedBox(height: 30.0),
            const Padding(
              padding: const EdgeInsets.only(left: 30.0, bottom: 14.0),
              child: const Text(
                "Users",
                style: const TextStyle(color: Colors.grey, fontSize: 17.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: _buildUsersList(screenSize),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Size size) {
    return FutureBuilder(
      future: _apiClient.getBanners(),
      builder: (BuildContext context,
          AsyncSnapshot<List<my.Banner>> bannersSnapshot) {
        if (bannersSnapshot.hasData) {
          return CarouselSlider(
            items: bannersSnapshot.data
                .map((my.Banner banner) =>
                    _buildSingleSlide(banner.banner, size))
                .toList(),
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayCurve: Curves.easeInToLinear,
            viewportFraction: 1.0,
            aspectRatio: 1.5,
          );
        }
        return const Center(child: const CircularProgressIndicator());
      },
    );
  }

  Widget _buildSingleSlide(String imageURL, Size size) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: const Radius.circular(45.0),
        bottomRight: const Radius.circular(45.0),
      ),
      child: Image.network(imageURL, width: size.width, fit: BoxFit.cover),
    );
  }

  Widget _buildEventsList(Size size) {
    return FutureBuilder(
      future: _apiClient.getEvents(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Event>> eventSnapshot) {
        if (eventSnapshot.hasData) {
          return Container(
            height: size.height / 3.1,
            child: ListView.separated(
              itemCount: eventSnapshot.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) =>
                  _buildSingleCard(eventSnapshot.data[index], size),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 18.0),
            ),
          );
        }
        return const Center(child: const CircularProgressIndicator());
      },
    );
  }

  Widget _buildSingleCard(Event event, Size size) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: const Radius.circular(100.0),
            topLeft: const Radius.circular(18.0),
            bottomLeft: const Radius.circular(18.0),
            bottomRight: const Radius.circular(18.0),
          ),
          child: Container(
            width: size.width / 1.3,
            child: Image.network(
              event.image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(color: Colors.grey[850], width: 1.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.network(
                    'https://via.placeholder.com/150',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    event.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    event.time,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
              child: const Icon(
                Icons.play_circle_filled,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, top: 10.0, bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width / 1.7,
                    child: Text(
                      event.description,
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: size.width / 1.7,
                    child: Text(
                      event.address,
                      style: const TextStyle(color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildUsersList(Size size) {
    return FutureBuilder(
      future: _apiClient.getUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> userSnapshot) {
        if (userSnapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userSnapshot.data.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildSingleUserListTile(userSnapshot.data[index], size),
            ),
          );
        }
        return const Center(child: const CircularProgressIndicator());
      },
    );
  }

  Widget _buildSingleUserListTile(User user, Size size) {
    return Card(
      elevation: 3.0,
      child: Container(
        width: size.width / 1.5,
        height: 100,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
                const NetworkImage('https://via.placeholder.com/150'),
            radius: 30.0,
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.name,
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                user.company.name,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          trailing: Text(
            user.address.city,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
