And(/^the mini cart counter increases to "([^"]*)"$/) do |string|
  on(MinicartPage) do |page|
    expect(page.mini_cart_quantity).to include string
  end
end
