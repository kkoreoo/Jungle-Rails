describe ('Jungle App', () => {
  it('Visits the home page', () => {
    cy.visit('/');
  });

  it("Navigates to the first product's detal page when the product is clicked", () => {
    cy.get(".products article").should("be.visible")
    cy.get(".products article").first().click()
    cy.url().should('include', '/products/2')
  });
});