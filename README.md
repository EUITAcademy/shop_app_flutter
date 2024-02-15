# Welcome to Shop App!

This is a walkthrough how to set up the backend server. And REST api documentation for test server.
# Set up Backend
### How to Run server.
1. Backend is located at in **backend** folder of the project.
2. To run backend you need to have Node.js installed on the computer. In order to run npm commands. Install node: https://nodejs.org/en
3. After that open terminal and go to **backend** folder. In terminal:
 `cd /Users/jack/Projects/shop_app_flutter/backend`
 next run server with `node app.js`.
 4. Now server is running, to quit server use ***control + C***. To run again use `node app.js`.

## Backend api

### Change localhost to local ip address
You can test local server **only** with local emulator installed on your computer. Test Server runs on *http://localhost:8080*. Unfortunately emulator doesn't understand localhost, so you need to change localhost to your local ip address. To change it you need to go to *Wifi-Settings/your connected network / tap details(three dots)/ network settings*, then you will see your local ip address. It should be similar to `193.172.21.17`

Now in starter project you need to change `localhost:8080` with `*your_ip*:8080`.
1. Go to *lib/api/shop_api.dart*. There change baseUrl to this format:

    static const String _baseUrl = 'http://193.172.21.17:8080';

2. In order to display images, you also need to change image paths in backend folder.
Go to *backend/data/dummy-items.json*. There change imageUrl field to this format: `"imageUrl": "http://193.172.21.17:8080/striped-shirt.jpeg",`

3. Remember to re-run the test server when you make changes in backend folder with `node app.js` in backend directory.

## REST API

Base url of server is *your_local_ip*:8080.

#### SignIn
**Method**: POST
**Endpoint**: `http://your_local_ip:8080/login`
**JsonBody**: `{'email': 'test@test.com', 'password': 'password'}`
**Headers**: none
**Example response**:

    {
    token: eyhbGciOiJIUzI1NiIsInR5I6IkpXVCJ9.eyJlbWFpbCImYUBhYS5jb0iLCJpYXQiOjE3Dc5ODk4MjsImV4cCITcwNzk5NzAyNX0.5XaXv-sj4X78MybKlHTCNQCkgHG8Pu5IOGW2Jos,
    exp: 2024-02-15T11:37:05.653Z
    }

#### SignUp
**Method**: POST
**Endpoint**: `http://your_local_ip:8080/signup`
**JsonBody**: `{'email': 'test@test.com', 'password': 'password'}`
**Headers**: none
**Example response**:

    {
    token: eyhbGciOiJIUzI1NiIsInR5I6IkpXVCJ9.eyJlbWFpbCImYUBhYS5jb0iLCJpYXQiOjE3Dc5ODk4MjsImV4cCITcwNzk5NzAyNX0.5XaXv-sj4X78MybKlHTCNQCkgHG8Pu5IOGW2Jos,
    exp: 2024-02-15T11:37:05.653Z
    }

#### Get products
**Method**: GET
**Endpoint**: `http://your_local_ip:8080/products`
**JsonBody**: none
**Headers**: `{'Authorization': 'Bearer your_token'},`
**Example response**:

    [
        {
            "id": "random_id_1",
      "title": "Boots man",
      "subtitle": "Black Elegant Boots",
      "imageUrl": "http://193.172.21.17:8080/boots_men.jpeg",
      "price": 109.99
      },
      {
            "id": "random_id_2",
      "title": "Hat",
      "subtitle": "Mans elegant brown hat",
      "imageUrl": "http://193.172.21.17:8080/hat.jpeg",
      "price": 119.99
      },
    ...

####  Order
**Method**: POST
**Endpoint**: `http://your_local_ip:8080/order`
**JsonBody**:

     {'order': [
            {
                "id": "random_id_1",
          "title": "Boots man",
          "subtitle": "Black Elegant Boots",
          "imageUrl": "http://193.172.21.17:8080/boots_men.jpeg",
          "price": 109.99
          },]
          }

**Headers**: `{'Authorization': 'Bearer your_token'},`
**Example response**:

     {'message': 'Order placed successfully!'}

