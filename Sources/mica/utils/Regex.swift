import Foundation

enum MatchRegexStatus {
  case matches
  case nomatch
}

struct MatchRegexResult {
  let status: MatchRegexStatus
  let results: [NSTextCheckingResult]
  let count: Int
}

func matchRegex(string: String, regex: NSRegularExpression) -> MatchRegexResult {
  let results = regex.matches(
    in: string, 
    range: NSRange(
      location: 0,
      length: string.count
    )
  )
  
  let count = results.count

  if count <= 0 {
    return MatchRegexResult(
      status: MatchRegexStatus.nomatch, 
      results: [],
      count: count
    )
  }

  return MatchRegexResult(
    status: MatchRegexStatus.matches, 
    results: results,
    count: count
  )
}