component BankingSystem {
  port sync in boolean w;
  port sync in int inp;

  port <<delayed>> sync out int output;

  BankAccountV2 acc;
  OverdraftLimit limit;

  w -> acc.w;
  w -> limit.w;

  inp -> acc.inp;
  inp -> limit.inp;

  acc.od -> limit.od;

  limit.fb -> acc.fb;

  limit.output -> output;
}