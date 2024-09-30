# tractian_challenge

Tractian Mobile Challenge

# Asset Management App

## Overview

### Context
Assets are essential to the operation of the industry, it can include everything from manufacturing equipment to transportation vehicles to power generation systems. Proper management and maintenance is crucial to ensure that they continue to operate efficiently and effectively. A practical way to visualize the hierarchy of assets is through a tree structure.

### Challenge
📌 Build an Tree View Application that shows companies Assets (The tree is basically composed with components, assets and locations)

### Key Features
- **Tree Structure**: Dynamically generated tree representing locations, assets, and components.
- **Filters & Search**: Sensor-type and status filters, with a search bar for quick lookup.
- **BLoC Pattern**: Business logic and state management are handled with Flutter's BLoC library.
- **Async Processing**: Offloads tree-building to background isolates for performance with large datasets.

---

## Architecture

### Layers

- **UI (Screens & Widgets)**: Reusable widgets for displaying data. Screens like `HomeScreen` and `AssetScreen` handle user interactions.
- **BLoC (State Management)**: Manages state for locations, assets, and the combined node tree. Major BLoCs:
  - `CompanyBloc`: Fetches companies.
  - `LocationBloc`: Fetches locations.
  - `AssetBloc`: Fetches assets.
  - `NodeBloc`: Builds the node tree and applies filters.
- **Data (Repositories & Services)**: Repositories handle data-fetching logic, using `ApiService` for API requests.
- **Utilities**: Helpers for building the node tree, applying filters, and handling API responses.

### Project Structure

```graphql
lib/
├── assets/
│   └── images/                     # Images used in the app (e.g., icons)
├── bloc/                           # BLoC components for managing app state
│   ├── asset/
│   ├── company/
│   ├── location/
│   └── node/
├── models/                         # Data models representing assets, locations, nodes, etc.
├── repositories/                   # Repositories for data access and API interaction
├── screens/                        # Screens (Home, Asset)
├── services/                       # API services for HTTP requests
├── utils/                          # Helper functions and utilities (tree building, filters, etc.)
└── widgets/                        # Reusable widgets (buttons, search bars, tree nodes)
```


---

## BLoC Pattern

The app uses 4 BLoCs for managing different parts of the state and business logic, each handling a different set of events and states. Below is an overview of the BLoCs used:

### 1. **CompanyBloc**
   - **Purpose**: Manages the loading of companies.
   - **Events**: `FetchCompanies` – triggered to retrieve the list of companies.
   - **States**:
     - `CompanyLoading` – indicates companies are being loaded.
     - `CompanyLoaded` – indicates companies have been successfully loaded.
     - `CompanyError` – error state when the fetching fails.

### 2. **LocationBloc**
   - **Purpose**: Manages the loading of locations for a specific company.
   - **Events**: `FetchLocations` – triggered to retrieve locations based on the selected company.
   - **States**:
     - `LocationLoading` – indicates locations are being loaded.
     - `LocationLoaded` – indicates locations have been successfully loaded.
     - `LocationError` – error state when the fetching fails.

### 3. **AssetBloc**
   - **Purpose**: Handles the loading of assets for the selected company.
   - **Events**: `FetchAssets` – triggered to retrieve assets for a company.
   - **States**:
     - `AssetLoading` – indicates assets are being loaded.
     - `AssetLoaded` – indicates assets have been successfully loaded.
     - `AssetError` – error state when the fetching fails.

### 4. **NodeBloc**
   - **Purpose**: Combines assets and locations to build a hierarchical node tree. Manages filtering and search functionality.
   - **Events**: 
     - `FetchNodes` – triggered to build the node tree from the loaded assets and locations.
   - **States**:
     - `NodeLoading` – indicates that the node data is being fetched.
     - `NodeProcessing` – indicates that the node tree is being built.
     - `NodeLoaded` – indicates the node tree has been successfully built and is ready for display.
     - `NodeError` – error state when the building of the node tree fails.



- Each **BLoC** handles a specific part of the state and isolates responsibilities, ensuring scalability and maintainability of the application. The `NodeBloc` integrates the data from both `AssetBloc` and `LocationBloc` to build the visual tree structure.

---

## Performance Improvements

1. **Offloading to Isolates**: Tree-building is offloaded to a background isolate using `compute()` to prevent UI blocking.
2. **Filter Efficiency**: Filters are applied once the tree is built, and the nodes are sorted to ensure locations with children appear first.

---

## Tests

This project includes 24 unit and bloc tests to ensure the app’s functionality is robust and reliable. The tests are categorized into the following areas:

- **BLoC Tests**: Validating the state transitions and event handling for all the main blocs (`CompanyBloc`, `AssetBloc`, `LocationBloc`, `NodeBloc`).
- **Service Tests**: Ensuring that the API service layer is properly fetching and parsing data from the backend.
- **Utility Function Tests**: Testing the helper function responsible for building the asset tree (`buildNodeTree`) and ensuring it's working efficiently with various inputs.

You can run the tests by executing:

```bash
flutter test
```

![image](https://github.com/user-attachments/assets/177a7816-f83a-4325-87d4-a5a1d8f9d7b6)


## Areas for Improvement

- **Lazy Loading**: Implement lazy loading of nodes to improve performance with very large datasets.
- **Caching**: Add caching for faster reloads and offline capabilities.
- **Advanced Error Handling**: More robust error handling with retry options.
- **Additional Tests**: Increase coverage of widget and unit tests, especially for edge cases.
- **UI Enhancements**: Add animations for smoother tree expansion and filter transitions.

---

## Screenshots

1. **Home Screen**: Company selection with buttons.
     
   <img src="https://github.com/user-attachments/assets/7a2766e0-a7e9-4e4a-91e2-c0c09f099499" alt="Home Screen" height="400">

3. **Asset Screen**: Asset tree visualization.
     
   <img src="https://github.com/user-attachments/assets/c7b6109e-b5f0-4ce0-80e2-0caf8a5f5492" alt="Asset Screen" height="400">

5. **Filtered Results**: Example of sensor-type and status filters applied.
     
   <img src="https://github.com/user-attachments/assets/82a25a19-6dbd-4337-914d-3e43656381c3" alt="Filtered Results" height="400">


## Video demonstration
[Screen_recording_20240930_202825.webm](https://github.com/user-attachments/assets/eb7d2f46-2d7d-4076-a83a-9d01b6867977)


---

## Conclusion

This app provides a clean, efficient way to manage and visualize large hierarchies of assets and locations. With further improvements like caching, lazy loading, and UI enhancements, the performance and user experience could be elevated significantly.

## Special Thanks

A big thanks to [Tractian](https://www.tractian.com/) for the opportunity to work on this challenge!
It was a great experience diving into asset management and hierarchical tree structures.
Looking forward to potential collaborations in the future!

## Connect with Me

If you have any questions or want to connect, feel free to reach out!

[LinkedIn: Guilherme F. Bastos](https://www.linkedin.com/in/guilherme-f-bastos/)


