# Stock Market App

# Description

A Flutter application that allows users to search for stock market data, view stock details, and visualize stock price graphs using provided APIs.

## Features

* User authentication (login via API)
* Search for stocks
* Retrieve stock details by ID
* Display stock price graphs
* State management using Riverpod
* Network requests handled with Dio

# Setup Instructions

## Prerequisites

* Flutter (latest stable version)
* Dart SDK
* Android Studio / VS Code (recommended for development)
* A connected device or emulator

## Installation

Clone the repository:

```
git clone https://github.com/hari070801/stock-market.git
cd stock_market_app
```

Install dependencies:

```
flutter pub get
```

Run the project:

```
flutter run
```

## Dependencies

The project uses the following packages:

* flutter_riverpod – for state management
* dio – for API calls
* shared_preferences – for local storage
* another_flushbar – for notifications
* cached_network_image – for optimized image loading
* fl_chart – for stock graph visualization
* connectivity_plus – for network connectivity detection

To view all dependencies, check pubspec.yaml.

## API Configuration

Base URL: https://illuminate-production.up.railway.app/api

**Authentication:**

Login: POST /auth/local

Request Body:

{
"identifier": "test@gmail.com",
"password": "Test@1234"
}

**Stock Search:**

Endpoint: GET /stocks/search?query="search text"

Requires Bearer Token Authentication

**Stock Details:**

Endpoint: GET /stocks/{stock_id}

Example: GET /stocks/8471

**Stock Price Graph:**

Endpoint: GET /stocks/{stock_id}/price-graph?range=1D

Allowed values for range: 1D, 1W, 1M, 1Y, 5Y

Example: GET /stocks/7972/price-graph?range=1D