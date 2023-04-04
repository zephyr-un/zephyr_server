# Zephyr Backend

This is the backend code for the Zephyr app, which is an app that helps users track their carbon emissions while traveling and suggests the most fuel-efficient route.

## Technologies Used
- Dart Frog Framework
- Google Cloud Firestore for data storage
- Google Cloud Run for serverless deployment
- Google Maps APIs (Routes API and Directions API) for calculating distances and emissions

## Prerequisites
- Dart SDK
- Firebase account and project with Firestore enabled
- Google Cloud API key (Routes API, Directions, Maps API Enabled)

## Installation
- Clone the repository
- Run `cd zephyr_server` and `pub get` to install dependencies
- Create a .env file with the following environment variables:
```
API_KEY=<Your Google Maps API key>
```

- Run the app using `dart_frog dev`

## Deployment
This app is set up to be deployed on Google Cloud Run. Simply push the code to a repository connected to your Google Cloud project and follow the instructions in the Google Cloud Run documentation. See the `deploy.sh` file for an example of how to deploy the app.


API Documentation
=================
GET/POST `/api/v1` - Base URL


POST `/api/v1/transport/[transport_type]` - Calculate emissions for a given transport type

Request Body:

``` json
Copy code
{
    "origin": 'Origin Location', // Json
    "estination": 'Destination Location', // Json
    "travelMode": 'TRAVEL MODE', // String
    "routingPreference": 'ROUTING PREFERENCE', // String
    "requestedReferenceRoutes": 'REFERENCE ROUTES', //String
    "vehicleInfo": 'VEHICLE INFO', // Json
}
```
Response Body:
    
``` json
    Copy code
    {
        "emissions": 'EMISSIONS', // Json
        "distance": 'DISTANCE', // Json
        "duration": 'DURATION', // Json
        "referenceRoutes": 'REFERENCE ROUTES', // Json
        "status": 'STATUS', // String
    }
```


## Contributing
Please read `CONTRIBUTING.md` for details on our code of conduct, and the process for submitting pull requests to us.

## License
This project is licensed under the MIT License - see the LICENSE file for details.





