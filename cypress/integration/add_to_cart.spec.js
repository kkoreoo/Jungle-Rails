describe ('Jungle App', () => {
  it('Visits the home page', () => {
    cy.visit('/');
  });

  it("We add the first item to the cart", () => {
    cy.get(".products article").should("be.visible")
    cy.get(".btn").first().click({force: true})
    cy.get(".nav-link").contains("a", "My Cart (1)")
  });
});