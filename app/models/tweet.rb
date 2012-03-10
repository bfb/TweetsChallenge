class Tweet
  include MongoMapper::Document         

  key :tweet  

  validates_presence_of :tweet

end