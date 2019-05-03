require 'dalia/survey_platform_api_wrapper'

class GenerateSurvey
  attr_accessor :title, :description, :author_source, :success, :survey

  PROJECT_UUID = "03c6d9f0-8cf0-0135-e3fc-04383552e34a"

  def initialize(fields = {})
    @title = fields[:title] || "Article Title!!"
    @description = fields[:description] || "Super Mega Description"
    @author_source = fields[:author_source] || "This is the Source!"
    @success = false
  end

  def generate!
    #Dalia::CampaignPlatformAPIWrapper.create_offer(offer_attribute_hash)
    begin 
      @survey = Dalia::SurveyPlatformAPIWrapper.create_survey(survey_attribute_hash)
      @success = true
    rescue Exception => e
      @success = false
    end
    self
  end

  def success?; @success; end

  def offer_attribute_hash
    offer = {
      :title => title,
      :max_publisher_reward_dollar => 100,
      :publisher_postback_active => false,
      :reward_dollar => 0,
      :target_groups => nil,
      :active => true,
      :provider_user_id => 1,
      :url => nil,
      :device_kinds => ["other", "mobile"]
    }

    {
      :uuid => UUID.new.generate,
      :project_uuid => PROJECT_UUID,
      :offer => offer
    }
  end

  def survey_attribute_hash(survey_default_values = {})
    survey = {
      :title => "Auto Gen Mega Survey",
      :pseudo_body => pseudo_body,
      :researcher_user_id => "DALIA_RESEARCH",
      :kind => "mr_survey",
      :is_completion_speed_control_active => false,
      :active => true
    }.merge(survey_default_values)

    hash = {
      :survey => survey
    }

    hash[:survey_uuid] = UUID.new.generate

    hash
  end

  def headline
    {
      "id": "1b9bc3ff-3d30-4be4-a24d-a6bb0f94d52b",
      "kind": "page",
      "body": {
        "page": "This is a recent headline in a major newspaper"
      }
    }
  end

  def title
    {
      "id": "Title_of_the_article",
      "kind": "page",
      "body": {
        "page": @title
      }
    }
  end

  def description
    {
      "id": "Description_of_the_article",
      "kind": "page",
      "body": {
        "page": @description
      }
    }
  end

  def author_source
    {
      "id": "Author_Source",
      "kind": "page",
      "body": {
        "page": @author_source
      }
    }
  end

  def relevancy
    {
      "id": "46d82b9b-105c-4568-9a3a-1984dff8cb3e",
      "kind": "multiple_sole",
      "title": "How relevant is this article for your personal life?",
      "notify_message": "Your best guess is fine",
      "body": {
        "options": [
          {
            "id": "O0010",
            "text": "Very relevant"
          },
          {
            "id": "O0020",
            "text": "Somewhat relvant"
          },
          {
            "id": "O0030",
            "text": "neutral"
          },
          {
            "id": "O0040",
            "text": "litte relevant"
          },
          {
            "id": "O0050",
            "text": "Not relevant"
          }
        ]
      }
    }
  end

  def pseudo_body
    {
      "locale": "en",
      "screens": [
        {
          "id": "c6867a02-5d9a-4c4d-8f54-6b48444bc7de",
          "questions": [
            headline,
            title,
            description,
            author_source,
            relevancy
          ]
        }
      ]
    }
  end
end
