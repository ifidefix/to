#[derive(Serialize, Deserialize, Debug)]
pub struct Settings {
    pub directories: Vec<String>,
	pub version: String
}
