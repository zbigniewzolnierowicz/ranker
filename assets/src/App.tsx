import { ChakraProvider, Link } from "@chakra-ui/react"
import { BrowserRouter as Router, Link as RouterLink, Route, Switch } from "react-router-dom"
import { Header } from "./components/Header"
import { About } from "./pages/About";
import { Home } from "./pages/Home";
import { Users } from "./pages/Users";

export const App = () => {
    return (
        <ChakraProvider>
        <Router>
          <div>
            <Header />
            <Switch>
              <Route path="/about">
                <About />
              </Route>
              <Route path="/users">
                <Users />
              </Route>
              <Route path="/">
                <Home />
              </Route>
            </Switch>
          </div>
        </Router>
        </ChakraProvider>
      );
    
}