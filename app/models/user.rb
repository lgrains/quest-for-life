# Copyright (c) 2009 Steven Hammond, Cris Necochea, Joe Lind, Jeremy Weiskotten
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

class User < ActiveRecord::Base
  include Clearance::User
  has_many :survey_groups
  
  attr_accessible :identity_url, :username
  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false, :allow_nil => true
  def self.teachers
    scoped(:include =>{:survey_groups => :surveys}).admin_is(false).email_confirmed_is(true)
  end

  # This flexible finder should return nil instead of RecordNotFound if it can't find the
  # listed record.
  # TODO: Should this really only return teachers? What about admins?
  def self.find_by_id_or_username(key)
    if key.instance_of?(Fixnum) || key =~ /^\d/
      return User.teachers.find_by_id(key.to_i)
    else
      return User.teachers.find_by_username(key)
    end
  end
  
  def to_param
    return "#{self.id}-#{self.username}"
  end
  
  def pretty_url
    # Under what condition should the username be blank?
    return self.username if self.email_confirmed? && !self.username.blank?
    return self.id
  end
  
  def validate
    errors.add("username", "cannot start with a number") if username =~ /^\d+/
  end
end
