import { ChakraProvider } from "@chakra-ui/react"
import { Header } from "./components/Header"

export const App = () => {
    return (
        <ChakraProvider>
            <Header />
        </ChakraProvider>
    )
}