package version

// Version of the application
type Version struct{}

func New(ver string) *Version {
	return &Version{}
}
