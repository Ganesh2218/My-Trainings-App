
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(Map<String, Set<String>>) onApply;

  const FilterBottomSheet({super.key, required this.onApply});

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {

  // List of tabs available for filtering
  final List<String> tabs = ['Location', 'Training Name', 'Trainer'];

  // Map containing filter options for each tab
  final Map<String, List<String>> filterOptions = {
    'Location': [
      'West Des Moines',
      'Chicago, IL',
      'Phoenix, AZ',
      'Dallas, TX',
      'San Diego, CA',
      'San Francisco, CA',
      'New York, ZK',
    ],
    'Training Name': [
      'Safe Scrum Master',
      'Agile Coach Certification',
      'Project Management',
      'Safe Scrum Master (6.0)',
      'Safe Scrum Master (4.6)',
    ],
    'Trainer': ['John Doe', 'Jane Smith', 'Michael Lee', 'Emily Clark'],
  };

  // Tracks selected filters for each category
  final Map<String, Set<String>> selectedFilters = {
    'Location': {},
    'Training Name': {},
    'Trainer': {},
  };

  // Keeps track of the currently selected tab
  String selectedTab = 'Location';

  // Search query entered in the search field
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter the options based on the selected tab and search query
    final filteredList = filterOptions[selectedTab]!
        .where((item) => item.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75, // Bottom sheet height
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header with title and close button
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Sort and Filters',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: Row(
              children: [
                // Left Section: Tabs for filtering categories
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 100,
                    child: ListView(
                      children: tabs.map((tab) {
                        return ListTile(
                          title: Text(
                            tab,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tab == selectedTab
                                  ? Colors.red // Highlight selected tab
                                  : Colors.black,
                            ),
                          ),
                          onTap: () {
                            // Switch the selected tab and clear search query
                            setState(() {
                              selectedTab = tab;
                              searchQuery = '';
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const VerticalDivider(),

                // Right Section Filter options and search functionality
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value; // Update the search query
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search), // Search icon
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Filter options list
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final item = filteredList[index];
                            final isSelected = selectedFilters[selectedTab]!.contains(item); // Check if item is selected

                            return CheckboxListTile(
                              title: Text(item),
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  // Add or remove the filter option based on checkbox state
                                  if (value == true) {
                                    selectedFilters[selectedTab]!.add(item);
                                  } else {
                                    selectedFilters[selectedTab]!.remove(item);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Apply Filters Button
          ElevatedButton(
            onPressed: () {
              widget.onApply(selectedFilters); // Pass selected filters back
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[500],
              foregroundColor: Colors.white,
            ),
            child: const Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}
