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

class SurveyGroupsController < ApplicationController
  before_filter :authenticate
  make_resourceful do
    actions :all
    response_for :create, :update, :destroy do |format|
      format.html { redirect_to current_user }
    end
  end

  def build_object
    @current_object = current_model.new(object_parameters)
    @current_object.user = current_user
    return @current_object
  end

  def current_object
    @current_object ||= current_user.survey_groups.find(params[:id])
  end

  def current_objects
    @survey_groups ||= current_user.survey_groups.paginate(:page => params[:page], :per_page => 20)
  end
  private
end
