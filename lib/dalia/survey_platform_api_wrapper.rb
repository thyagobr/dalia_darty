module Dalia
  module SurveyPlatformAPIWrapper
    APP_CONFIG = {
      survey_platform_api: {
        api_host: "http://surveyplatform.daliaresearch.com.pizza",
        survey_interface_host: "http://surveyinterfaceclient-v2.daliaresearch.com.pizza",
        account_id: "DALIA_RESEARCH",
        debug_mode: true,
        mock_mode: false,
        token: '8263e9d1b23bcca95173f15799575e72549f31ae98aa00cffca8abc527fb3d2601221fc1ce337cfdfbcb9a37776d763333941e7b499ccab07aa6862a7a788a2b'
      }
    }

    def self.client
      @client ||=
        Dalia::Api::SurveyPlatform::Client.new(
          :account_id => APP_CONFIG[:survey_platform_api][:account_id],
          :api_host => APP_CONFIG[:survey_platform_api][:api_host],
          :debug_mode => APP_CONFIG[:survey_platform_api][:debug_mode],
          :mock_mode => APP_CONFIG[:survey_platform_api][:mock_mode],
          :token => APP_CONFIG[:survey_platform_api][:token],
          :logger => Logger.new($stdout)
        )
    end

    def self.fetch_survey(survey_uuid)
      begin
        client.fetch_survey({:survey_id => survey_uuid})[:survey]
      rescue Dalia::Api::SurveyPlatform::RequestException
        return nil
      end
    end

    def self.create_survey(survey_attributes)
      client.send_survey({:data => survey_attributes[:survey]})
    end

    def self.update_survey(survey_attributes)
      client.update_survey({:survey_id => survey_attributes[:survey_uuid], :data => survey_attributes[:survey]})
    end

    def self.duplicate_survey(survey_uuid)
      client.duplicate_survey( { :survey_id => survey_uuid } )[:survey]
    end

    def self.compile_survey(pseudo_body)
      client.compile_survey(pseudo_body)
    end

    def self.cross_check(survey_uuids)
      client.cross_check(survey_uuids: survey_uuids)
    end

    def self.spot_checks(survey_uuid)
      client.spot_checks(survey_id: survey_uuid)
    end

    def self.automatic_weighting_info(survey_uuid, target_groups)
      client.automatic_weighting_info(survey_id: survey_uuid, target_groups: target_groups)[:info]
    end

    def self.merge_survey_bodies(survey_uuids)
      client.merge_survey_bodies(uuids: survey_uuids)[:body]
    end

    def self.automatic_weighting(survey_uuid, target_groups)
      client.automatic_weighting(survey_id: survey_uuid, target_groups: target_groups)[:status] == 'ok'
    end

  end
end
