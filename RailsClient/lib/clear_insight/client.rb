module ClearInsight
  class Client<Base
    ENTRY_CREATE_UPDATE_API='/api/v1/kpi_entry/entry'
    HOST='http://localhost:8000/'
    TOKEN=''

    attr_accessor :host, :token, :retries, :time_out, :open_time_out, :client, :retry_count

    def initialize(host=HOST, token=TOKEN, retries=5, time_out=nil, open_time_out=nil)
      self.host=host
      self.token =token
      self.retries =retries
      self.time_out=time_out
      self.open_time_out=open_time_out
      self.retry_count=0
    end


    def entry(kpi_entry)
      kpi_entry_json=kpi_entry.to_json
      self.client=initialize_rest_client(ENTRY_CREATE_UPDATE_API)
      recall_entry(kpi_entry_json)
    end

    def recall_entry(kpi_entry_json)
      self.retry_count+=1
      begin
        if retry_count<=retries
          puts "===============#{retry_count}"
          res=client.post({entry: kpi_entry_json})
          msg=JSON.parse(res.body)
          puts "#{msg}------#{res.code}----------------#{res.to_json}"
          if res.code==201 || res.code==200
            puts '-----------------------------------------true-'
            return true
          else
            puts '*****************************************false'
            return recall_entry(kpi_entry_json)
          end
        end
      rescue => e
        puts "ERROR: #{e.message}"
        return recall_entry(kpi_entry_json)
      end
    end

    def initialize_rest_client(api)
      RestClient::Resource.new("#{self.host}#{api}",
                               timeout: self.time_out,
                               open_time_out: self.open_time_out,
                               content_type: 'application/json')
    end
  end
end