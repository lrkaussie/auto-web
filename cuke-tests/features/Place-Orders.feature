Feature: Place Order Utility For Testers

  @multipletimes @datamagic_order_details
  Scenario: Place Order on AU/NZ/US site
    Given I add test products products to bag
    And I fill all the order details from "order_details.yml" file
    When I place the order
    Then I see the thank you page
