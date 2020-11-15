# README

## Name

Wildat Sports Performance Tracker

## Description

This web application is designed for a high school/college strength and conditioning coach. Coaches (users) can log in by creating a new account or using their google email. Once logged in, coaches can add students and log their performance tests. Not only does this application save time, it allows coaches to easily assess individual and overall progress. For example, coaches can filter students and results by graduation year, date, type, and top performers. 

## Installation

Before starting the server, create a new `.env` file in the root of your project directory. This is where you will store your CLIENT_ID and CLIENT_SECRET for Google OAuth. Visit [Google Cloud Platform](https://console.cloud.google.com/) to set up credentials for your application. Add the CLIENT_ID and CLIENT_SECRET to your `.env` file and make sure the `.env` is added to `Gitignore`. 

Next, run `rails s` to start the server. Navigate to the homepage [localhost:3000/](localhost:3000/), where you will either create a new user or log in via google. After logging in, begin adding students and their respective performance tests!

## Support

Ask questions or send feedback to `katelynrpeterson16@gmail.com`.

## Contributor's Guide

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://opensource.org/licenses/MIT)
