enum ScheduleFilter {
  daily('Daily'),
  weekly('Weekly'),
  monthly('Monthly'),
  yearly('Yearly');

  final String value;
  const ScheduleFilter(this.value);
}
