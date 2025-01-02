import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_trainings_app/screens/training_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/training.dart';
import '../providers/training_provider.dart';
import '../utils/vertical_divider.dart';
import 'filter_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filteredTrainings = Provider.of<TrainingProvider>(context).filteredTrainings;
    final highlights = Provider.of<TrainingProvider>(context).highlights;
    final trainings = Provider.of<TrainingProvider>(context).trainings;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trainings',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Displays a CarouselSlider with training highlights, a filter button, and a clear filters button.
            SizedBox(
              height: 340,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(height: 190, color: Colors.red),
                      Container(height: 150, color: Colors.white),
                    ],
                  ),

                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 35),
                      child: Text(
                        'Highlights',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  //Displays CarouselSlider
                  Align(
                    alignment: Alignment.center,
                    child: CarouselSlider.builder(
                      itemCount: highlights.length,
                      options: CarouselOptions(
                        height: 170,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final highlight = highlights[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                highlight.image,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      highlight.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      highlight.location,
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                    Text(
                                      highlight.dates,
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                    Text(
                                      highlight.price,
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  //Filter
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.filter_list),
                        label: const Text('Filter'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            isScrollControlled: true,
                            builder: (context) => FilterBottomSheet(
                              onApply: (selectedFilters) {
                                final provider =
                                Provider.of<TrainingProvider>(context, listen: false);
                                provider.filterTrainings(
                                  locations: selectedFilters['Location'],
                                  trainingNames: selectedFilters['Training Name'],
                                  trainers: selectedFilters['Trainer'],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  //Clear
                  if(filteredTrainings.isNotEmpty)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.clear_all),
                          label: const Text('Clear'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          onPressed: () {
                            final provider = Provider.of<TrainingProvider>(context, listen: false);
                            provider.clearFilters();
                          },
                        ),
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(height: 16),
            getTrainings(trainings)
          ],
        ),
      ),
    );
  }

  Widget getTrainings(List<Training> trainings){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trainings.length,
      itemBuilder: (context, index) {
        final training = trainings[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TrainingDetailScreen(training: trainings[index]),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              child: Row(
                children: [
                  // Date, Time, Location Column
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          training.date,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          training.time,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            training.location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Divider
                  VerticalDottedDivider(
                    height: 130,
                    dotWidth: 2,
                    dotHeight: 6,
                    color: Colors.grey.shade500,
                  ),
                  // Details Column
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            training.status,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            training.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(training.image),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Keynote Speaker',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      training.trainer,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                              onPressed: () {
                                // Add functionality here
                              },
                              child: const Text('Enroll Now'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}
