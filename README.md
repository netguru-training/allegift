# AlleGift

This application is a convenient way for choosing presents for friends, relatives, colleagues, etc. It is especially useful on the eve of Christmas holidays.

The application flow is the following:

* sigh in using your facebook/google+ account or register on the website
* select "Make a wish" to add a gift from Allegro that you want to receive
* users who want to find a gift to others should click "Be Santa"
* in order to see the gifts that you have chosen to give to others go to "My gifts to others"
* to display your wish list click "My wish list"

## Deploying
In order to deploy the app on heroku.com do this:

* Clone the application locally:

  `git clone https://github.com/netguru-training/allegift.git`

* create an empty app on heroku, with postgres - replace 'crazysheeps' with your own app name:

  `heroku apps:create crazysheeps --addons heroku-postgresql`

* push the app to heroku, let them do their thing:

  `git push heroku`

* load the database schema

  `heroku run rake db:schema:load`

## Configuration
To enable log in via facebook/google+ set these variables in your file .env
  ```shell
  FACEBOOK_KEY
  FACEBOOK_SECRET
  GOOGLE_CLIENT_ID
  GOOGLE_CLIENT_SECRET
  ```
For integration with AllegroApi provide also:
  ```shell
  ALLEGRO_KEY
  ALLEGRO_LOGIN
  ALLEGRO_HASH_PASSWORD
  ```
Allegro password can be hashed [here] (https://quickhash.com/) by setting sha-256 and base64 parameters.

For [video chat feature] (https://tokbox.com/opentok/) to work add these variables:
  ```shell
  OPENTOK_API_KEY
  OPENTOK_API_SECRET
  ```

## App on Heroku
You can try the application [here](http://allegift.herokuapp.com/ )
