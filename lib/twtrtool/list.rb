require "twitter"
require "twtrtool/with_retries"

module Twtrtool
  class List 
    class DoesNotExistError < ArgumentError; end
  
    include WithRetries
  
    class << self
      def exist?(list_name)
        with_retries{ Twitter.lists.map(&:name).include?(list_name) }
      end
  
      def create_private_list(list_name)
        with_retries{ Twitter.list_create(list_name, mode: "private") }
      end
    end

  
    attr_reader :name
  
    def initialize(name, must_exist: false)
      @name = name
      raise DoesNotExistError, "List '#{name}' does not exist." if must_exist && !exist?
    end
  
    def exist?
      self.class.exist?(name)
    end
  
    def create_as_private_list
      self.class.create_private_list(name)
    end
  
    def create_or_sync_inverse_list
      List.new("#{name}-i").tap do |list|
        list.create_as_private_list unless list.exist?
        list.set_members(friend_ids_not_in_this_list)
      end
    end

    def member_ids
      @member_ids ||= with_retries{ Twitter.list_members(name).map(&:id) }
    end

    def remove_members(member_ids)
      puts " -> removing #{member_ids.size} members: " + member_ids.join(', ')
      with_retries{ Twitter.list_remove_members(name, member_ids) }
    end
  
    def add_members(member_ids)
      puts " -> adding #{member_ids.size} members: " + member_ids.join(', ')
      with_retries{ Twitter.list_add_members(name, member_ids) }
    end
  
    def friend_ids_not_in_this_list
      friend_ids = with_retries{ Twitter.friend_ids.all }
      friend_ids - member_ids
    end

    def set_members(new_member_ids)
      superfluous_member_ids = member_ids - new_member_ids
      missing_member_ids     = new_member_ids - member_ids
      remove_members(superfluous_member_ids)
      add_members(missing_member_ids)
      @member_ids = nil # memoized value is no longer valid
    end
  end
end