component OverdraftLimit {

  port sync in boolean w;
  port sync in int inp;
  port sync in int od;

  port <<delayed>> sync out int fb;
  port <<delayed>> sync out int output;

  int limit = 0;

  <<delayed>> automaton {

    initial state Tracking;

    /*
     * Reject overdraft:
     * od > limit
     */
    Tracking -> Tracking [w && od > limit] / {
      fb = inp;
      output = 0;
    };

    /*
     * Allow overdraft
     */
    Tracking -> Tracking [w && od <= limit] / {
      fb = 0;
      output = inp;
    };

    /*
     * New largest deposit
     */
    Tracking -> Tracking [!w && inp > limit] / {
      fb = 0;
      output = 0;
      limit = inp;
    };

    /*
     * Deposit smaller than current limit
     */
    Tracking -> Tracking [!w && inp <= limit] / {
      fb = 0;
      output = 0;
    };
  }
}