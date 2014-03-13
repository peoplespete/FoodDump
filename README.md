Food Dump
=========

Food Dump was created for use by any of the 1 in 5 people who suffer from a digestive disease. [Source](http://digestive.niddk.nih.gov/statistics/statistics.aspx)

Why?
-----------
In the seventh grade I was diagnosed with a digestive disease and was told by doctors that the best thing I could do was to be very diligent about recording what I ate and the quality of my stool and then correlate the two.  I found it annoying to try and keep track of everything and further sometimes I had other uses for the paper.  This app allows sufferers of digestive diseases to easily record what they've eaten and the quality of their stools using a simple and intuitive interface.  It even allows users to predict whether or not other foods will affect them adversely, before it is too late.

Setup
------
Run from your command line:
```
git clone https://github.com/peoplespete/FoodDump.git
cd FoodDump
bundle
```
Add application.yml file:
```
touch config/application.yml
```
Add your own [Yummly](https://developer.yummly.com/) keys in the application.yml file you just created:

```
YUMMLY_APP_ID : 5j353d43
YUMMLY_KEY : erf49d23c9a634344f5e1kk3k42314i4
```
Start the app:

```
rails server
```

The app should now be running at localhost:3000


How To Use
-----------
This web app is designed for anyone who suffers from a digestive disease.

1. Every time you eat something, click `Food Log`.
2. Add the food you just ate, checking the `Simple Food?` box if the food is itself an ingredient (examples: milk, apple, broccoli, etc.)

1. Every time you have a bowel movement, click `Stool Status`.
2. Use the slider to rate the quality of your stool from loose to normal to hard.

1. If you would like a recommendation on how a food may affect your digestive system, click `Crystal Ball`.
2. Add the food you are contemplating eating and use the result to help you decide what to eat. ^

^ The prediction abilities of the Crystal Ball are directly proportional to how much data is in the database.  The more food log and stool statuses you complete, the more accurate your Crystall Ball will be.


Additional Resources
--------------------
This app was built using HAML, SASS, JS, and a Ruby on Rails back end.  Recipe information provided by [Yummly](https://developer.yummly.com/).

![alt tag](/app/assets/images/digestive_system.png)