import 'package:flutter/material.dart';
import '../models/highlight.dart';
import '../models/training.dart';

class TrainingProvider extends ChangeNotifier {
  //Insert Dummy Content in the Highlights Models
  final List<Highlight> _highlights = [
    Highlight(
      title: 'Safe Scrum Master',
      location: 'West Des Moines, IA',
      dates: '30 Oct - 31 Oct',
      price: '\$825',
      image: 'assets/banner.png',
    ),
    Highlight(
      title: 'Agile Leadership',
      location: 'Los Angeles, CA',
      dates: '15 Nov - 16 Nov',
      price: '\$950',
      image: 'assets/banner.png',
    ),
  ];

  //Insert Dummy Content in the Training Models
  final List<Training> _trainings = [
    Training(
      date: 'Oct 11 - 13, 2019',
      time: '08:30 am - 12:30 pm',
      title: 'Safe Scrum Master (4.6)',
      status: 'Filling Fast!',
      location: 'West Des Moines',
      trainer: 'John Doe',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'
    ),
    Training(
      date: 'Nov 15 - 16, 2019',
      time: '09:00 am - 05:00 pm',
      title: 'Agile Coach Certification',
      status: 'Early Bird Offer',
      location: 'San Diego, CA',
      trainer: 'Jane Smith',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'

    ),
    Training(
      date: 'Dec 01 - 02, 2019',
      time: '10:00 am - 04:00 pm',
      title: 'Project Management',
      status: 'Filling Fast!',
      location: 'Phoenix, AZ',
      trainer: 'Michael Lee',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'

    ),
    Training(
      date: 'Dec 10 - 12, 2019',
      time: '11:00 am - 05:00 pm',
      title: 'Safe Scrum Master',
      status: 'Limited Seats',
      location: 'New York, ZK',
      trainer: 'Emily Clark',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'

    ),
    Training(
      date: 'Jan 20 - 22, 2025',
      time: '09:00 am - 05:00 pm',
      title: 'Agile Coach Advanced',
      status: 'Early Bird Offer',
      location: 'Chicago, IL asdfghjkrtyuihgjhknkuygungukkkkkkkkkkkkkfbtttttttttttttuhhhhhhhhhhhh',
      trainer: 'John Doe',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'

    ),
    Training(
      date: 'Feb 14 - 16, 2025',
      time: '08:30 am - 12:30 pm',
      title: 'Scrum Master Fundamentals sdfghjkjhhjhkuuhujkjjkhjgjhbjk',
      status: 'Filling Fast!',
      location: 'San Francisco, CA',
      trainer: 'Michael Lee',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'

    ),
    Training(
      date: 'Mar 5 - 7, 2025',
      time: '10:00 am - 04:00 pm',
      title: 'Project Management',
      status: 'Limited Seats',
      location: 'Dallas, TX',
      trainer: 'Emily Clark',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'

    ),
    Training(
      date: 'Apr 18 - 20, 2025',
      time: '09:00 am - 05:00 pm',
      title: 'Agile Coach Certification',
      status: 'Filling Fast!',
      location: 'Phoenix, AZ',
      trainer: 'Jane Smith',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'

    ),
    Training(
      date: 'May 8 - 10, 2025',
      time: '08:30 am - 12:30 pm',
      title: 'Safe Scrum Master (6.0)',
      status: 'Early Bird Offer',
      location: 'San Diego, CA',
      trainer: 'John Doe',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'

    ),
    Training(
      date: 'Jun 15 - 17, 2025',
      time: '10:00 am - 04:00 pm',
      title: 'Project Management',
      status: 'Limited Seats',
      location: 'New York, ZK',
      trainer: 'Michael Lee',
      image: 'assets/banner.png',
      summary: 'This training equips participants with the skills and knowledge to implement Agile methodologies effectively in their teams and organizations. Learn from industry-leading experts about frameworks like Scrum, Kanban, and SAFe, and gain hands-on experience with real-world case studies'

    ),
  ];


  List<Training> filteredTrainings = [];

  // Creates a new copy of the lists
  List<Highlight> get highlights => [..._highlights];
  List<Training> get trainings =>
      filteredTrainings.isEmpty ? [..._trainings] : [...filteredTrainings];

  void filterTrainings({
    Set<String>? locations,
    Set<String>? trainingNames,
    Set<String>? trainers,
  }) {
    filteredTrainings = _trainings.where((training) {
      final matchesLocation = locations == null || locations.isEmpty || locations.contains(training.location);
      final matchesTrainingName = trainingNames == null || trainingNames.isEmpty || trainingNames.contains(training.title);
      final matchesTrainer = trainers == null || trainers.isEmpty || trainers.contains(training.trainer);

      // Include only if all selected filters match
      return matchesLocation && matchesTrainingName && matchesTrainer;
    }).toList();

    notifyListeners(); // Notify the UI to rebuild with the new filtered list
  }

  void clearFilters() {
    filteredTrainings = [];
    notifyListeners();
  }
}
