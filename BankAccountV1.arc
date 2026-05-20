component BankAccountV1 {

  port sync in boolean w;
  port sync in int inp;

  port sync out int output;

  int balance = 0;

  automaton {

    initial state Active;

    /*
     * Deposit
     */
    Active -> Active [!w] / {
      balance = balance + inp;
      output = 0;
    };

    /*
     * Successful withdrawal
     */
    Active -> Active [w && balance >= inp] / {
      balance = balance - inp;
      output = inp;
    };

    /*
     * Failed withdrawal
     */
    Active -> Active [w && balance < inp] / {
      output = 0;
    };
  }
}