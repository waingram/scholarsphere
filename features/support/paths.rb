# Copyright © 2012 The Pennsylvania State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    
    case page_name
  
    when /the home\s?page/
      '/'
    when /the search page/
      '/catalog'
    when /ingest/
      new_generic_file_path
    when /logout/
      destroy_user_session_path
    when /my account info/
      edit_user_registration_path
    when /the base search page/
      '/catalog?q=&search_field=search&action=index&controller=catalog&commit=search'
    when /the document page for id (.+)/ 
      catalog_path($1)
    when /the edit page for id (.+)/ 
      edit_catalog_path($1)
    when /the catalog index page/
      catalog_index_path
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    when /dashboard/
      dashboard_path

    when /the edit document page for (.*)$/i
      edit_catalog_path($1)
    when /the show document page for (.*)$/i
      catalog_path($1)
    when /the delete confirmation page for (.*)$/i
      delete_catalog_path($1)
      
    when /the file (?:asset )?list page for (.*)$/i
      asset_file_assets_path($1)
    when /the file asset creation page for (.*)$/i
      asset_file_assets_path($1)
    when /the deletable file list page for (.*)/i
      asset_file_assets_path($1, :deletable=>"true",:layout=>"false")
    when /the file asset (.*) with (.*) as its container$/i
      asset_file_asset_path($2, $1)
    when /the file asset (.*)$/i
      file_asset_path($1)
    when /the permissions page for (.*)$/i
      asset_permissions_path($1)
    
    when /new (.*) page$/i
      new_asset_path(:content_type => $1)
    when /the asset (.*)$/i
      asset_path($1)
    when /show asset page for (.*)$/i
      asset_path($1)

      
    when /the (\d+)(?:st|nd|rd|th) (person|organization|conference) entry in (.*)$/i
      # contributor_id = "#{$2}_#{$1.to_i-1}"
      asset_contributor_path($3, $2, $1.to_i-1, :content_type=>"mods_asset")
    
    when /the edit (.*) page for (.*)$/i
      edit_catalog_path($2,:wf_step=>$1)
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
      
  end

end

World(NavigationHelpers)
