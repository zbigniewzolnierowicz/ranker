import { Text, TextProps } from "@chakra-ui/react";
import { FC } from "react";

export const Bold: FC<TextProps> = ({ children, as: _as, fontWeight: _bold, ...rest }) => (
    <Text as="span" fontWeight="bold" {...rest}>{children}</Text>
)