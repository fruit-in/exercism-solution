pub mod graph {
    use std::collections::HashMap;

    use self::graph_items::edge::Edge;
    use self::graph_items::node::Node;

    pub struct Graph {
        pub nodes: Vec<Node>,
        pub edges: Vec<Edge>,
        pub attrs: HashMap<String, String>,
    }

    impl Graph {
        pub fn new() -> Self {
            Self {
                nodes: vec![],
                edges: vec![],
                attrs: HashMap::new(),
            }
        }

        pub fn with_nodes(mut self, nodes: &[Node]) -> Self {
            self.nodes = nodes.to_vec();

            self
        }

        pub fn with_edges(mut self, edges: &[Edge]) -> Self {
            self.edges = edges.to_vec();

            self
        }

        pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
            self.attrs = attrs
                .into_iter()
                .map(|(k, v)| (k.to_string(), v.to_string()))
                .collect();

            self
        }

        pub fn get_node(&self, name: &str) -> Option<Node> {
            self.nodes.iter().find(|&node| node.name == name).cloned()
        }

        pub fn get_edge(&self, from: &str, to: &str) -> Option<Edge> {
            self.edges
                .iter()
                .find(|&edge| edge.from == from && edge.to == to)
                .cloned()
        }

        pub fn get_attr(&self, key: &str) -> Option<&str> {
            self.attrs.get(key).map(|v| v.as_str())
        }
    }

    pub mod graph_items {
        pub mod node {
            use std::collections::HashMap;

            #[derive(Clone, Debug, PartialEq)]
            pub struct Node {
                pub name: String,
                attrs: HashMap<String, String>,
            }

            impl Node {
                pub fn new(name: &str) -> Self {
                    Self {
                        name: name.to_string(),
                        attrs: HashMap::new(),
                    }
                }

                pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
                    self.attrs = attrs
                        .into_iter()
                        .map(|(k, v)| (k.to_string(), v.to_string()))
                        .collect();

                    self
                }

                pub fn get_attr(&self, key: &str) -> Option<&str> {
                    self.attrs.get(key).map(|v| v.as_str())
                }
            }
        }

        pub mod edge {
            use std::collections::HashMap;

            #[derive(Clone, Debug, PartialEq)]
            pub struct Edge {
                pub from: String,
                pub to: String,
                attrs: HashMap<String, String>,
            }

            impl Edge {
                pub fn new(from: &str, to: &str) -> Self {
                    Self {
                        from: from.to_string(),
                        to: to.to_string(),
                        attrs: HashMap::new(),
                    }
                }

                pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
                    self.attrs = attrs
                        .into_iter()
                        .map(|(k, v)| (k.to_string(), v.to_string()))
                        .collect();

                    self
                }

                pub fn get_attr(&self, key: &str) -> Option<&str> {
                    self.attrs.get(key).map(|v| v.as_str())
                }
            }
        }
    }
}
