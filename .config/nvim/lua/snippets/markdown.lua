return {
  s("diary-now", fmt("### {} - {}", {
    p(os.date, "%H:%M"),
    i(1, "Your text here")
  }))
}
