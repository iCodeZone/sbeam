package sbeam.po.game;

import java.io.Serializable;
import java.util.Objects;

public class GameAndType implements Serializable {
    private Integer gameId;
    private Integer gameTypeId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        GameAndType that = (GameAndType) o;
        return Objects.equals(gameId, that.gameId) &&
                Objects.equals(gameTypeId, that.gameTypeId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(gameId, gameTypeId);
    }

    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }

    public Integer getGameTypeId() {
        return gameTypeId;
    }

    public void setGameTypeId(Integer gameTypeId) {
        this.gameTypeId = gameTypeId;
    }
}
