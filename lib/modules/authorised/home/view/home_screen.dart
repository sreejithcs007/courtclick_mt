import 'package:courtclick_mt/modules/authorised/downloads/view/downloads_screen.dart';
import 'package:courtclick_mt/modules/authorised/home/models/movie_model.dart';
import 'package:courtclick_mt/modules/authorised/more/view/more_screen.dart';
import 'package:courtclick_mt/widget/continue_watching_section/continue_watching_section.dart';
import 'package:courtclick_mt/widget/featured_banner/featured_banner.dart';
import 'package:courtclick_mt/widget/netflix_bottom_nav/netflix_bottom_nav.dart';
import 'package:courtclick_mt/widget/previews_section/previews_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String profileName;

  const HomeScreen({super.key, this.profileName = 'Emenalo'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;

  Widget _buildTabBody() {
    switch (_currentTabIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const Center(
          child: Text(
            'Search Screen',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        );
      case 2:
        return const Center(
          child: Text(
            'Coming Soon Screen',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        );
      case 3:
        return const DownloadsScreen();
      case 4:
        return MoreScreen(activeProfile: widget.profileName);
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Banner
          FeaturedBanner(
            movie: MockHomeData.featuredMovie,
            onPlayTap: () {
              debugPrint('Play tapped');
            },
            onMyListTap: () {
              debugPrint('My List tapped');
            },
            onInfoTap: () {
              debugPrint('Info tapped');
            },
          ),

          const SizedBox(height: 16),

          // Previews Section
          PreviewsSection(
            previews: MockHomeData.previews,
            onPreviewTap: (movie) {
              debugPrint('Preview tapped: ${movie.title}');
            },
          ),

          const SizedBox(height: 16),

          // Continue Watching Section
          ContinueWatchingSection(
            profileName: widget.profileName,
            movies: MockHomeData.continueWatching,
            onMovieTap: (movie) {
              debugPrint('Continue watching tapped: ${movie.title}');
            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildTabBody(),
      bottomNavigationBar: NetflixBottomNav(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }
}
