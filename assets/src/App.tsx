import React from "react"
import { useCookies } from "./hooks/useCookies"
import { client } from "./utils/client"
import { ChakraProvider, Link } from "@chakra-ui/react"
import { Header } from "./components/Header"

export const App = () => {
    return (
        <ChakraProvider>
            <Header />
        </ChakraProvider>
    )
}