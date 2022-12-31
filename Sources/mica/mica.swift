@main
public struct mica {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(mica().text)
    }
}
