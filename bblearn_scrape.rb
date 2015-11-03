require 'rubygems'
require 'mechanize'
require 'open-uri'

if ARGV.length != 4
  $stderr.puts "USAGE: ./bblearn_scrape username password pdf_url \"directory/name/like/this\""
  exit(0)
end

USERNAME = ARGV[0]
PASSWORD = ARGV[1]
PDFURL = ARGV[2]
DESTDIR = ARGV[3]

if(not File.directory?(DESTDIR))
  $stderr.puts "ERROR: Output folder \"%s\" does not exist." % (DESTDIR)
  exit(0)
end


def format_forms(page)
  ret = {}
  page.forms.each do |form|
    ret[form.name] = []
    form.fields.each do |n|
      ret[form.name] << n.name
    end
  end
  return ret
end

# Logs into blackboard, 
# returns a cookie you can use for next request
def bb_login(username, password, bb_url)
  mech = Mechanize.new
  mech.log = Logger.new $stderr

  # Load website and log us in
  page = mech.get(bb_url)
  forms = format_forms(page)
  form = page.form_with :name => 'login'
  form.user_id = USERNAME
  form.password = PASSWORD
  form.submit

  #save the cookie jar for next request
  ret_jar = mech.cookie_jar
  return ret_jar
end

def get_pdfs(cookie_jar, regex, destdir, bb_pdf_index)
  mech = Mechanize.new
  mech.cookie_jar = cookie_jar

  page = mech.get(bb_pdf_index)
  puts "PageTitle: " + page.title

  page.links_with(:href => regex).each do |link|
    puts "downloading: " + link.href
    pdf = mech.get(link.href)
    puts "---downloaded: " + pdf.filename

    loc = destdir + pdf.filename
    puts "saving to: " + loc
    pdf.save(loc)
  end
end

cookie_jar = bb_login(USERNAME, PASSWORD, "https://bblearn.utk.edu/")
get_pdfs(cookie_jar, /bbcswebdav/, DESTDIR, PDFURL)

