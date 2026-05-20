component BankAccountV2 {

  port sync in boolean w;
  port sync in int inp;
  port sync in int fb;

  port <<delayed>> sync out int od;

  int balance = 0;

  <<delayed>> automaton {

    initial state Active;

    /*
     * Deposit
     */
    Active -> Active [!w] / {
      od = 0;
      balance = balance + fb + inp;
    };

    /*
     * Withdrawal without overdraft
     */
    Active -> Active [w && balance >= inp] / {
      od = 0;
      balance = balance + fb - inp;
    };

    /*
     * Withdrawal with overdraft
     */
    Active -> Active [w && balance < inp] / {
      od = inp - balance;
      balance = balance + fb - inp;
    };
  }
}