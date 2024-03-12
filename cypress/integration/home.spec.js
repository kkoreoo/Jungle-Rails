describe ('Jungle App', () => {
  it('Visits the home page', () => {
    cy.visit('/');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
});