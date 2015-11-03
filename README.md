# BlackBoard Learn File Scraper

I got tired of having to manually download links on blackboard like this:

![right click save as? no pls](http://i.imgur.com/4YOlQSS.png).

So to learn some webscraping with login, I cobbled together a script that would do it for me.
Thanks to the Mechanize gem, it was pretty easy.


#Usage
1. Clone this repo.
2. Install the following gems if you have not already:
  - rubygems
  - mechanize
  - open-uri
3. Navigate to the cloned directory and run:
  - `ruby bblearn_scrape username password file_index_url "directory/name/like/this"`
    -`password`: bblearn password
    -`username`: bblearn username
    -`file_index_url`: the bblearn url containing the files you wish to download
    -`directory...`: the output directory



# License
You may use this code freely, but you get what you pay for -- there is absolutely no warranty.
