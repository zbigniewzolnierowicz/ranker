import { Box, Heading, Text } from "@chakra-ui/react"
import { useMemo } from "react"
import { useSelector } from "react-redux"
import { Bold } from "../components/textFormatting/Bold"
import { H1, H2 } from "../components/textFormatting/Headings"
import { RootState } from "../store"
import { IUser } from "../types/user"

export const Me = () => {
    const userData = useSelector<RootState, IUser>(state => state.user.user_data)
    const { poolSpendUntil, poolSpendStart } = useMemo(() => {
        const poolSpendStart = new Date(userData.pool.year, userData.pool.month)
        const poolSpendUntil = poolSpendStart
        poolSpendUntil.setMonth(userData.pool.month + 1)
        return {
            poolSpendStart,
            poolSpendUntil
        }
    }, [userData])
    return (
        <Box maxW="120ch" mx="auto" mt={12}>
            <H1>About you</H1>
            <H2>Data</H2>
            <Text><Bold>Email:</Bold> {userData.email}</Text>
            <Text><Bold>Points to spend:</Bold> {userData.spendable_points}</Text>
            <Text><Bold>Sendable points:</Bold> {userData.pool.points}</Text>
            <Text>(You can send these points between {poolSpendStart.toLocaleDateString()} and {poolSpendUntil.toLocaleDateString()})</Text>
            <H2>Benefits shop</H2>
        </Box>
    )
}