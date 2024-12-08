require 'spec_helper'

describe AssignPartners do

  it 'should assign a different giver and getter to each partnership' do
    event = create(:event)

    users = create_list(:user, 7, :with_membership, event_id: event.id)

    result = AssignPartners.call(event.id)

    assert result

    event.reload

    assert_equal 7, event.partnerships.count

    assert event.partnerships.all? { |p| p.valid? }
    assert event.partnerships.all? { |p| p.giver != p.getter }
  end

  it 'should not assign a giver to a getter that has excluded them' do
    event = create(:event)
    santa = create(:user, :with_membership, fname: 'Santa', lname: 'Claus', event_id: event.id)
    mrs_claus = create(:user, :with_membership, fname: 'Mrs.', lname: 'Claus', event_id: event.id)
    create(:exclusion, user_id: santa.id, excluded_user_id: mrs_claus.id)
    create(:exclusion, user_id: mrs_claus.id, excluded_user_id: santa.id)

    rudy = create(:user, :with_membership, fname: 'Rudolph', lname: 'Reindeer', event_id: event.id)
    dancer = create(:user, :with_membership, fname: 'Dancer', lname: 'Reindeer', event_id: event.id)
    create(:exclusion, user_id: rudy.id, excluded_user_id: dancer.id)
    create(:exclusion, user_id: dancer.id, excluded_user_id: rudy.id)

    comet = create(:user, :with_membership, fname: 'Comet', lname: 'Reindeer', event_id: event.id)
    blitzen = create(:user, :with_membership, fname: 'Blitzen', lname: 'Reindeer', event_id: event.id)
    cupid = create(:user, :with_membership, fname: 'Cupid', lname: 'Reindeer', event_id: event.id)
    donner = create(:user, :with_membership, fname: 'Donner', lname: 'Reindeer', event_id: event.id)

    result = AssignPartners.call(event.id)

    assert result

    event.reload

    assert_equal 8, event.partnerships.count

    assert event.partnerships.all? { |p| p.valid? }
    assert event.partnerships.all? { |p| p.giver != p.getter }

    assert event.partnerships.none? { |p| p.giver == santa && p.getter == mrs_claus }
    assert event.partnerships.none? { |p| p.giver == mrs_claus && p.getter == santa }
    assert event.partnerships.none? { |p| p.giver == rudy && p.getter == dancer }
    assert event.partnerships.none? { |p| p.giver == dancer && p.getter == rudy }
  end

  it 'should return false if the number of attemps is greater than 5' do
    event = create(:event)
    users = create_list(:user, 7, :with_membership, event_id: event.id)

    refute AssignPartners.call(event.id, 6)
  end

  it 'should return false if the number of users is less than 2' do
    event = create(:event)
    user = create(:user, :with_membership, event_id: event.id)

    refute AssignPartners.call(event.id)
  end
end
